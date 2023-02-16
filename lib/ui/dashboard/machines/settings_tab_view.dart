import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/city_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/widget/app_debug_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import '../../../core/viewmodel/machine_view_model.dart';
import '../../widget/button/white_app_button.dart';
import '../../widget/utility/no_data_widget.dart';

class SettingsTabView extends StatefulWidget {
  const SettingsTabView({Key? key}) : super(key: key);

  @override
  State<SettingsTabView> createState() => _SettingsTabViewState();
}

class _SettingsTabViewState extends State<SettingsTabView> {
  // final List<_PositionItem> _positionItems = <_PositionItem>[];
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final _formKey = GlobalKey<FormState>();
  final _machineNameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final machineViewModel = context.read<MachineViewModel>();
    final authViewModel = context.read<AuthViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await authViewModel.getCities();
      machineViewModel.autoValidateModeSettings = AutovalidateMode.disabled;
      _machineNameController.text =
          machineViewModel.selectedMahcine.machineName.toString();
      _addressController.text =
          machineViewModel.selectedMahcine.address.toString();
      machineViewModel.enableVoice =
          machineViewModel.selectedMahcine.voice == AppStatus.normal
              ? true
              : false;
      machineViewModel.enableWaterHeater =
          machineViewModel.selectedMahcine.waterHeater == AppStatus.normal
              ? true
              : false;
      machineViewModel.enableFoamHeater =
          machineViewModel.selectedMahcine.foamHeater == AppStatus.normal
              ? true
              : false;
      machineViewModel.enableLight =
          machineViewModel.selectedMahcine.light == AppStatus.normal
              ? true
              : false;
      machineViewModel.enablePublicAccess =
          machineViewModel.selectedMahcine.publicAccess == AppStatus.normal
              ? true
              : false;
      machineViewModel.enableMaintenance =
          machineViewModel.selectedMahcine.maintenanceMode == AppStatus.abnormal
              ? true
              : false;
      authViewModel.selectedCity = authViewModel.cityList.firstWhere(
          (element) => element.id == machineViewModel.selectedMahcine.cityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Form(
        key: _formKey,
        autovalidateMode: machineViewModel.autoValidateModeSettings,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Text(
                "Settings",
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xff212121),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 18, bottom: 20, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Machine Information",
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Machine Name",
                    style: GoogleFonts.nunitoSans(
                      color: Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    controller: _machineNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter machine name';
                      }
                      return null;
                    },
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
                      hintText: "Machine Name",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Address",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 17),
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
                        hintText: "Address",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 58,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: const Color(0xFFEAEAEA),
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Theme(
                      // <- Here
                      data: Theme.of(context).copyWith(
                        // <- Here
                        splashColor: Colors.transparent, // <- Here
                        highlightColor: Colors.transparent, // <- Here
                        hoverColor: Colors.transparent, // <- Here
                      ),
                      child: authViewModel.cityList.isEmpty
                          ? const SizedBox()
                          : DropdownButtonHideUnderline(
                              child: DropdownButton<Data>(
                                value: authViewModel.selectedCity,
                                icon: SvgPicture.asset(
                                    'assets/svg/arrow-down-icon.svg'),
                                elevation: 16,
                                // style: GoogleFonts.nunitoSans(
                                //   color:
                                //       authViewModel.selectedCity.cityName ==
                                //               '-Select-'
                                //           ? const Color(0xff898989)
                                //           : const Color(0xff212121),
                                // ),
                                onChanged: (Data? value) {
                                  // This is called when the user selects an item.
                                  authViewModel.selectedCity = value!;
                                },
                                items: authViewModel.cityList
                                    .map<DropdownMenuItem<Data>>((Data value) {
                                  return DropdownMenuItem<Data>(
                                    value: value,
                                    child: Text(
                                      value.cityName.toString(),
                                      style: GoogleFonts.nunitoSans(
                                        color: value.cityName == '-Select City-'
                                            ? const Color(0xff898989)
                                            : const Color(0xff212121),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // WhiteAppButton(
                  //     onTap: () {
                  //       _getCurrentPosition(machineViewModel);
                  //     },
                  //     title: "Get Current Location"),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffeaeaea),
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          _getCurrentPosition(machineViewModel);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Current Location",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xff00ab6c),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Only press when you are next to your machine to get the exact machine location",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xff00ab6c),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (machineViewModel.currentPosition != null) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        "Latitude ${machineViewModel.currentPosition?.latitude} Longitude ${machineViewModel.currentPosition?.longitude}",
                        style: GoogleFonts.nunitoSans(fontSize: 10),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 25, bottom: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          "Voice",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            height: 1.52,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 51,
                          height: 31,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: machineViewModel.enableVoice,
                              onChanged: (value) {
                                machineViewModel.enableVoice = value;
                              },
                              activeColor: const Color(0xFF00AB6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffeaeaea),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 20, top: 25),
                    child: Row(
                      children: [
                        Text(
                          "Water Heater",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            height: 1.52,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 51,
                          height: 31,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: machineViewModel.enableWaterHeater,
                              onChanged: (value) {
                                machineViewModel.enableWaterHeater = value;
                              },
                              activeColor: const Color(0xFF00AB6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffeaeaea),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 20, top: 25),
                    child: Row(
                      children: [
                        Text(
                          "Foam Heater",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            height: 1.52,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 51,
                          height: 31,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: machineViewModel.enableFoamHeater,
                              onChanged: (value) {
                                machineViewModel.enableFoamHeater = value;
                              },
                              activeColor: const Color(0xFF00AB6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffeaeaea),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 20, top: 25),
                    child: Row(
                      children: [
                        Text(
                          "Light",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            height: 1.52,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 51,
                          height: 31,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: machineViewModel.enableLight,
                              onChanged: (value) {
                                machineViewModel.enableLight = value;
                              },
                              activeColor: const Color(0xFF00AB6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffeaeaea),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 20, top: 25),
                    child: Row(
                      children: [
                        Text(
                          "Maintenance Mode",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            height: 1.52,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 51,
                          height: 31,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: machineViewModel.enableMaintenance,
                              onChanged: (value) {
                                machineViewModel.enableMaintenance = value;
                              },
                              activeColor: const Color(0xFF00AB6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: const Color(0xffeaeaea),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Text(
                          "Public Access",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            height: 1.52,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 51,
                          height: 31,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: machineViewModel.enablePublicAccess,
                              onChanged: (value) {
                                machineViewModel.enablePublicAccess = value;
                              },
                              activeColor: const Color(0xFF00AB6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: WhiteAppButton(
                onTap: () {
                  // machineViewModel.saveMachineSettings();
                  if (authViewModel.selectedCity.id == null) {
                    Fluttertoast.showToast(msg: 'Please select your city');
                  }
                  // else if (machineViewModel.currentPosition == null) {
                  //   Fluttertoast.showToast(
                  //       msg:
                  //           "Please tap Get Current Location to fetch current location.");
                  // }
                  else if (_formKey.currentState!.validate()) {
                    machineViewModel.saveMachineSettings(
                        machineName: _machineNameController.text,
                        address: _addressController.text,
                        cityId: authViewModel.selectedCity.id.toString());
                  } else {
                    machineViewModel.autoValidateModeSettings =
                        AutovalidateMode.always;
                  }
                },
                title: 'Save',
                borderColor: const Color(0xff00ab6c),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
          ],
        ),
      ),
    );
  }

  // void _updatePositionList(Position position) {
  //   appDebugPrint("displayValue ${position.latitude}  ${position.longitude} ");
  //   // _positionItems.add(_PositionItem(type, displayValue));
  //   setState(() {});
  // }

  Future<void> _getCurrentPosition(MachineViewModel machineViewModel) async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best));
    machineViewModel.currentPosition = position;
    appDebugPrint(
        "currentPosition ${machineViewModel.currentPosition?.latitude}  ${machineViewModel.currentPosition?.longitude}");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    machineViewModel.placemark = placemarks.first;
    placemarks.forEach((element) {
      appDebugPrint("state ${element.administrativeArea}");
      appDebugPrint("subAdministrativeArea ${element.subAdministrativeArea}");
      appDebugPrint("country ${element.country}");
      appDebugPrint("postalCode ${element.postalCode}");
    });
    // _updatePositionList(
    //   position,
    // );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      appDebugPrint(
          'WARNING  Location services are not enabled don\'t continue '
          'accessing the position and request users of the'
          'App to enable the location services.');
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Fluttertoast.showToast(msg: "Please allow location");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Fluttertoast.showToast(
          msg: "Location is mandatory, Please allow manually");
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }
}
