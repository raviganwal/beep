import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodel/machine_view_model.dart';
import '../../widget/button/white_app_button.dart';
import '../../widget/utility/no_data_widget.dart';

class SettingsTabView extends StatefulWidget {
  const SettingsTabView({Key? key}) : super(key: key);

  @override
  State<SettingsTabView> createState() => _SettingsTabViewState();
}

class _SettingsTabViewState extends State<SettingsTabView> {
  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: ListView(
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
            padding:
                const EdgeInsets.only(top: 18, bottom: 20, left: 24, right: 24),
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                  ),
                ),
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
              onTap: () {},
              title: 'Save',
              borderColor: const Color(0xff00ab6c),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}
