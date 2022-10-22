import 'package:beep/core/viewmodel/team_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widget/button/app_button.dart';

class AddTeamMemberView extends StatefulWidget {
  const AddTeamMemberView({Key? key}) : super(key: key);

  @override
  State<AddTeamMemberView> createState() => _AddTeamMemberViewState();
}

class _AddTeamMemberViewState extends State<AddTeamMemberView> {
  @override
  Widget build(BuildContext context) {
    final teamViewModel = context.watch<TeamViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4.0),
              blurRadius: 12.0,
            )
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black)),
            title: Text(
              "Add Team Member",
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 30),
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
        child: Stack(
          children: [
            ListView(
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
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
                      hintText: "Input Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                    hintText: "Input Email",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                    hintText: "Input Email",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Role",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: teamViewModel.selectedRole,
                        icon:
                            SvgPicture.asset('assets/svg/arrow-down-icon.svg'),
                        elevation: 16,
                        style: GoogleFonts.nunitoSans(
                          color: teamViewModel.selectedAssignTo == '-Select-'
                              ? const Color(0xff898989)
                              : const Color(0xff212121),
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            teamViewModel.selectedRole = value!;
                          });
                        },
                        items: teamViewModel.roleList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Assign to",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: teamViewModel.selectedAssignTo,
                        icon:
                            SvgPicture.asset('assets/svg/arrow-down-icon.svg'),
                        elevation: 16,
                        style: GoogleFonts.nunitoSans(
                          color: teamViewModel.selectedAssignTo == '-Select-'
                              ? const Color(0xff898989)
                              : const Color(0xff212121),
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            teamViewModel.selectedAssignTo = value!;
                          });
                        },
                        items: teamViewModel.assignToList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 40),
                        child: AppButton(
                          onTap: () {},
                          title: "Update",
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AppButton(
                      onTap: () {},
                      title: "Add New Member",
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
