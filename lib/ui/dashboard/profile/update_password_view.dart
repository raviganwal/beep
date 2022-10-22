import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/button/app_button.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  @override
  Widget build(BuildContext context) {
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
              "Update Password",
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
                  "Current Password",
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
                  "New Password",
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
                  "Confirm Password",
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
                      onTap: () {
                        _passwordUpdated();
                      },
                      title: "Update",
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  _passwordUpdated() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(28),
          //     topRight: Radius.circular(28),
          //   ),
          //   color: Colors.white,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: Text(
                        "Update Password",
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
              const SizedBox(
                height: 39,
              ),
              SvgPicture.asset("assets/svg/machine-added.svg"),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Password Updated",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xff212121),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: "Done",
                  )),
              const SizedBox(
                height: 53,
              ),
            ],
          ),
        );
      },
    );
  }
}
