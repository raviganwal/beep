import 'package:beep/core/app_status.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widget/utility/no_data_widget.dart';

class StatsTabView extends StatefulWidget {
  const StatsTabView({Key? key}) : super(key: key);

  @override
  State<StatsTabView> createState() => _StatsTabViewState();
}

class _StatsTabViewState extends State<StatsTabView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final machineViewModel = context.read<MachineViewModel>();
      machineViewModel.getMachineDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 30),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xffeaeaea),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          machineViewModel.checkMachineStatus(
                                      machine:
                                          machineViewModel.selectedMahcine) ==
                                  MachineStatus.offline
                              ? 'assets/png/machine-image-offline.png'
                              : 'assets/png/machine-image.png',
                          width: 134,
                          height: 165,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Machine Status",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 13,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: machineViewModel.checkMachineStatus() ==
                                      MachineStatus.operatesNormally
                                  ? const Color(0xffe7faf3)
                                  : machineViewModel.checkMachineStatus() ==
                                          MachineStatus.needAttention
                                      ? const Color(0xffffe7e2)
                                      : const Color(0xFFEAEAEA),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  machineViewModel.checkMachineStatus() ==
                                          MachineStatus.operatesNormally
                                      ? 'assets/svg/circle-check.svg'
                                      : machineViewModel.checkMachineStatus() ==
                                              MachineStatus.needAttention
                                          ? 'assets/svg/info-icon-red.svg'
                                          : 'assets/svg/offline-icon.svg',
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  machineViewModel.checkMachineStatus() ==
                                          MachineStatus.operatesNormally
                                      ? "Operate Normally"
                                      : machineViewModel.checkMachineStatus() ==
                                              MachineStatus.needAttention
                                          ? "Need Attentions"
                                          : "Offline",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    color:
                                        machineViewModel.checkMachineStatus() ==
                                                MachineStatus.operatesNormally
                                            ? const Color(0xff00ab6c)
                                            : machineViewModel
                                                        .checkMachineStatus() ==
                                                    MachineStatus.needAttention
                                                ? const Color(0xffde2800)
                                                : const Color(0xFF898989),
                                    fontSize: 13,
                                    height: 1.69,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            width: 150,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  machineViewModel.checkMachineStatus() ==
                                          MachineStatus.offline
                                      ? 'assets/svg/foam-icon-grey.svg'
                                      : machineViewModel
                                                  .selectedMahcine.foamTank ==
                                              AppStatus.foamNormal
                                          ? 'assets/svg/foam-icon.svg'
                                          : 'assets/svg/foam-icon-red.svg',
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Foam",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff212121),
                                    fontSize: 11,
                                    height: 1.54545454545,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: machineViewModel
                                              .selectedMahcine.foamTank ==
                                          AppStatus.foamNormal
                                      ? const Color(0xffeaeaea)
                                      : const Color(0xffde2800)
                                          .withOpacity(.15),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 130,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color:
                                      machineViewModel.checkMachineStatus() ==
                                              MachineStatus.offline
                                          ? const Color(0xffc4c4c4)
                                          : machineViewModel.selectedMahcine
                                                      .foamTank ==
                                                  AppStatus.foamNormal
                                              ? const Color(0xff00dd8d)
                                              : const Color(0xffde2800),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            width: 150,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    machineViewModel.checkMachineStatus() ==
                                            MachineStatus.offline
                                        ? 'assets/svg/water-icon-grey.svg'
                                        : machineViewModel.selectedMahcine
                                                    .waterTank ==
                                                AppStatus.waterNormal
                                            ? 'assets/svg/water-icon.svg'
                                            : 'assets/svg/water-icon-red.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Water",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff212121),
                                    fontSize: 11,
                                    height: 1.54545454545,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: machineViewModel
                                              .selectedMahcine.waterTank ==
                                          AppStatus.waterNormal
                                      ? const Color(0xffeaeaea)
                                      : const Color(0xffde2800)
                                          .withOpacity(.15),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 130,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color:
                                      machineViewModel.checkMachineStatus() ==
                                              MachineStatus.offline
                                          ? const Color(0xffc4c4c4)
                                          : machineViewModel.selectedMahcine
                                                      .waterTank ==
                                                  AppStatus.waterNormal
                                              ? const Color(0xff00ab6c)
                                              : const Color(0xffde2800),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Machine Address",
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 13,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    machineViewModel.selectedMahcine.address.toString(),
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      height: 1.52,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              child: DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            // indicatorWeight: 0,
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xff00ab6c), width: 5.0),
                              ),
                            ),
                            labelColor: const Color(0xff00ab6c),
                            labelStyle: GoogleFonts.nunitoSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            unselectedLabelStyle: GoogleFonts.nunitoSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            unselectedLabelColor: const Color(0xff898989),
                            tabs: const [
                              Tab(
                                text: "Daily Stats",
                              ),
                              Tab(
                                text: "Monthly Stats",
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 400, //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: const TabBarView(children: <Widget>[
                              NoDataWidget(),
                              NoDataWidget(),
                            ]))
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
