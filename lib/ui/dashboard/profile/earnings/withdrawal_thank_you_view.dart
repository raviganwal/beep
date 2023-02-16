import 'package:beep/ui/widget/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawalThankYouView extends StatelessWidget {
  const WithdrawalThankYouView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/png/drone_delivery.png",
                    width: 250,
                    height: 178,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Thank you! We are sending your money to your local bank account",
                    textAlign: TextAlign.center,
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
                    "The process may take 2-3 working days. No need to worry, sit comfortably, and check your email. We will provide updates via your email notification",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff898989),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? AppButton(
                          onTap: () {
                            _gotIt(context);
                          },
                          title: "Got It!",
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: AppButton(
                        onTap: () {
                          _gotIt(context);
                        },
                        title: "Got It!",
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void _gotIt(BuildContext context) {
    Navigator.of(context).pop();
  }
}
