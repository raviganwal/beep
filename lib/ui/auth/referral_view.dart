import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/auth/signup_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../widget/button/app_button.dart';
import '../widget/rich_text/tc_rich_text.dart';

class ReferralView extends StatefulWidget {
  const ReferralView({Key? key}) : super(key: key);

  @override
  State<ReferralView> createState() => _ReferralViewState();
}

class _ReferralViewState extends State<ReferralView> {
  final _formKey = GlobalKey<FormState>();
  final _referralCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.isReferralApplied = false;
    });
  }

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
                key: _formKey,
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/png/referral.png",
                      width: 180,
                      height: 220,
                    ),
                    const SizedBox(
                      height: 49,
                    ),
                    Text(
                      "Got a Referral Code?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(0),
                              ),
                              border: Border.all(
                                color: const Color(0xffeaeaea),
                                width: 1,
                              ),
                              color: authViewModel.isReferralApplied
                                  ? const Color(0xFFE7FBF4)
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: _referralCodeController,
                                    enabled: authViewModel.isReferralApplied
                                        ? false
                                        : true,
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.only(
                                          left: 20, right: 16),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: const Color(0xFF898989),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                      hintText: "Referral Code",
                                    ),
                                    style: GoogleFonts.nunitoSans(
                                      color: authViewModel.isReferralApplied
                                          ? const Color(0xff00ab6c)
                                          : const Color(0xFF212121),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (authViewModel.isReferralApplied)
                                  Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      child: SvgPicture.asset(
                                          'assets/svg/circle-check.svg'))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            border: Border.all(
                              color: const Color(0xff00ab6c),
                              width: 0,
                            ),
                            color: const Color(0xff00ab6c),
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              onTap: authViewModel.isReferralApplied
                                  ? null
                                  : () {
                                      if (_referralCodeController
                                          .text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'Please select referral code');
                                      } else {
                                        authViewModel.applyReferralCode(
                                            referralCode:
                                                _referralCodeController.text);
                                      }
                                    },
                              child: Container(
                                width: 121,
                                height: 57,
                                alignment: Alignment.center,
                                child: Text(
                                  authViewModel.isReferralApplied
                                      ? "Applied"
                                      : "Apply",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff898989),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? AppButton(
                            onTap: () {
                              _next(authViewModel);
                            },
                            title: "Sign Up",
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
                          _next(authViewModel);
                        },
                        title: "Sign Up",
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  _next(AuthViewModel authViewModel) async {
    authViewModel.submitSignup();
  }
}
