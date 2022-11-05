import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/auth/referral_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../widget/button/app_button.dart';
import '../widget/rich_text/tc_rich_text.dart';

class OtpView extends StatefulWidget {
  final String phoneNumber;

  const OtpView({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xffdef1ea)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Form(
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/png/phone.png",
                      width: 180,
                      height: 220,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "OTP Code",
                      style: GoogleFonts.nunitoSans(
                          color: const Color(0xFF212121),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380,
                      child: Text(
                        "We have sent a verification code on your phone number ${widget.phoneNumber} Please enter the four number of verification code below",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                            color: const Color(0xff898989),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OtpTextField(
                          numberOfFields: 4,
                          borderColor: const Color(0xFFD9D9D9),
                          focusedBorderColor: const Color(0xFF00AB6C),
                          // styles: otpTextStyles,
                          showFieldAsBox: false,
                          borderWidth: 2.0,
                          fieldWidth: MediaQuery.of(context).size.width * .16,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          textStyle: GoogleFonts.nunitoSans(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff212121),
                          ),
                          onCodeChanged: (String code) {
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) {
                            authViewModel.otpCodeInput = verificationCode;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Don’t receive the OTP?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff898989),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        authViewModel.resendOtp();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Resend Code",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff00ab6c),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? AppButton(
                            onTap: () {
                              if (authViewModel.otpCodeInput.isEmpty &&
                                  authViewModel.otpCodeInput.length < 3) {
                                Fluttertoast.showToast(msg: 'Please enter OTP');
                              } else {
                                authViewModel.otpVerification();
                              }
                            },
                            title: "Next",
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: AppButton(
                        onTap: () {
                          if (authViewModel.otpCodeInput.isEmpty &&
                              authViewModel.otpCodeInput.length < 3) {
                            Fluttertoast.showToast(msg: 'Please enter OTP');
                          } else {
                            authViewModel.otpVerification();
                          }
                        },
                        title: "Next",
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
