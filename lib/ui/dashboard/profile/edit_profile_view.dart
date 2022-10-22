import 'package:beep/ui/dashboard/profile/update_password_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_locator.dart';
import '../../../core/service/navigation_service.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
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
              "Edit Profile",
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {},
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Save",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff00ab6c),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 30),
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 17, bottom: 30),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  "Account Information",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "First Name",
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
                      hintText: ""),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Last Name",
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
                      hintText: ""),
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
                      hintText: ""),
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
                      hintText: ""),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
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
                      suffixIcon: Container(
                        width: 80,
                        // alignment: Alignment.center,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            onTap: () async {
                              await locator<NavigationService>()
                                  .navigateToWidget(const UpdatePasswordView());
                            },
                            child: Center(
                              child: Text(
                                "Update",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xff00ab6c),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      hintText: ""),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 17, bottom: 23),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  "Bank Information",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Bank Name",
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
                      hintText: ""),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Account Number",
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
                      hintText: ""),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Account Name",
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
                      hintText: ""),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
