import 'dart:developer';
import 'dart:io';

import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:beep/ui/widget/button/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widget/button/white_app_button.dart';

class AddMachineView extends StatefulWidget {
  const AddMachineView({Key? key}) : super(key: key);

  @override
  State<AddMachineView> createState() => _AddMachineViewState();
}

class _AddMachineViewState extends State<AddMachineView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      reassemble();
    });
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.\
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          SafeArea(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      machineViewModel.flashToggle =
                          !machineViewModel.flashToggle;
                      setState(() {});
                    },
                    icon: machineViewModel.flashToggle
                        ? SvgPicture.asset('assets/svg/flash_icon_on.svg')
                        : SvgPicture.asset('assets/svg/flash_icon.svg')),
              ],
            ),
          ),
          Positioned(
            top: 113,
            left: 50,
            right: 50,
            child: SafeArea(
              child: Text(
                "Scan the code on the machine to add the machine to the App",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xffeaeaea),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 35,
              left: 24,
              right: 24,
              child: WhiteAppButton(
                onTap: () {
                  inputCodeModal();
                },
                title: 'Input Machine Code',
              ))
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = MediaQuery.of(context).size.height * .33;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xFF8F8F8F),
          borderRadius: 30,
          borderLength: 50,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  inputCodeModal() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (BuildContext context) {
        final machineViewModel = context.watch<MachineViewModel>();
        return Container(
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(28),
          //     topRight: Radius.circular(28),
          //   ),
          //   color: Colors.white,
          // ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: Text(
                        "Add Machine",
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
              if (!machineViewModel.isMachineAdded) ...[
                const SizedBox(
                  height: 103,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFFEAEAEA),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFEAEAEA),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFEAEAEA),
                          ),
                        ),
                        hintStyle: GoogleFonts.nunitoSans(
                            color: const Color(0xFF898989),
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                        hintText: "Machine"),
                  ),
                ),
                const SizedBox(
                  height: 111,
                ),
              ],
              if (machineViewModel.isMachineAdded) ...[
                const SizedBox(
                  height: 27,
                ),
                SvgPicture.asset("assets/svg/machine-added.svg"),
                const SizedBox(
                  height: 38,
                ),
                Text(
                  "Beep Machine Added Successfully",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 61,
                ),
              ],
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppButton(
                      onTap: () {
                        machineViewModel.isMachineAdded =
                            !machineViewModel.isMachineAdded;
                      },
                      title:
                          !machineViewModel.isMachineAdded ? 'Save' : 'Ok'))
            ],
          ),
        );
      },
    );
  }
}
