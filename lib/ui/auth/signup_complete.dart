import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../widget/button/app_button.dart';
import '../widget/rich_text/tc_rich_text.dart';

class SignupComplete extends StatefulWidget {
  const SignupComplete({Key? key}) : super(key: key);

  @override
  State<SignupComplete> createState() => _SignupCompleteState();
}

class _SignupCompleteState extends State<SignupComplete> {
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
                      "assets/png/complete.png",
                      width: 163,
                      height: 316,
                    ),
                    const SizedBox(
                      height: 49,
                    ),
                    Text(
                      "Thank you for applying to become\nan operator",
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
                      "Hang on tight while your application is being reviewed. A beep representative will contact you via email within the next days.",
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
                              _next();
                            },
                            title: "Got It!",
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
                          _next();
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

  _next() async {
     locator<NavigationService>()
        .navigateAndRemoveWidget(const DashboardView());
  }
}
