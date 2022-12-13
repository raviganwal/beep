import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/auth/referral_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
      resizeToAvoidBottomInset: true,
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
                      width: 139,
                      height: 170,
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
                    PinCodeTextField(
                      scrollPadding: const EdgeInsets.only(bottom:300),
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                          // borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: MediaQuery.of(context).size.width * .16,
                          activeFillColor: Colors.transparent,
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          selectedColor: const Color(0xFF00AB6C),
                          selectedFillColor: Colors.transparent,
                          inactiveColor: const Color(0xFFD9D9D9),
                          inactiveFillColor: Colors.transparent
                          //     borderColor: const Color(0xFFD9D9D9),
                          // focusedBorderColor: const Color(0xFF00AB6C),
                          ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      // controller: textEditingController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                      pastedTextStyle: GoogleFonts.nunitoSans(
                        color: const Color(0xff212121),
                      ),
                      textStyle: GoogleFonts.nunitoSans(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff212121),
                      ),
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
