import 'package:beep/core/app_validators.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/auth/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../widget/button/app_button.dart';
import '../widget/rich_text/tc_rich_text.dart';
import '../widget/textfield/app_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    Image.asset(
                      "assets/png/logo.png",
                      width: 165,
                      height: 63,
                    ),
                    const SizedBox(
                      height: 106,
                    ),
                    Text(
                      'Create your Account',
                      style: GoogleFonts.nunitoSans(
                          color: const Color(0xFF212121),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    AppTextField(
                      controller: _emailController,
                      hintText: "First Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textAlign: TextAlign.center,
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       contentPadding:
                    //           const EdgeInsets.symmetric(horizontal: 20),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12.0),
                    //         borderSide: const BorderSide(
                    //           width: 1,
                    //           color: Color(0xFFEAEAEA),
                    //         ),
                    //       ),
                    //       focusedBorder: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(12),
                    //         ),
                    //         borderSide: BorderSide(
                    //           width: 1,
                    //           color: Color(0xFFEAEAEA),
                    //         ),
                    //       ),
                    //       enabledBorder: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(12),
                    //         ),
                    //         borderSide: BorderSide(
                    //           width: 1,
                    //           color: Color(0xFFEAEAEA),
                    //         ),
                    //       ),
                    //       hintStyle: GoogleFonts.nunitoSans(
                    //           color: const Color(0xFF898989),
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.w600),
                    //       hintText: "First Name"),
                    // ),
                    const SizedBox(
                      height: 20,
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
                          hintText: "Last Name"),
                    ),
                    const SizedBox(
                      height: 20,
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
                          hintText: "Phone Number"),
                    ),
                    const SizedBox(
                      height: 20,
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
                          hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 20,
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
                          hintText: "Password"),
                    ),
                    const SizedBox(
                      height: 20,
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
                          hintText: "Confirm Password"),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: authViewModel.checkTandC,
                          onChanged: (val) {
                            authViewModel.checkTandC = val!;
                          },
                        ),
                        Flexible(
                            child: Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: const TermsRichText()))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Figma Flutter Generator ButtonregularlargeWidget - INSTANCE
                    AppButton(
                      onTap: () {
                        _goToOtp();
                      },
                      title: "Next",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _goToOtp() async {
    await locator<NavigationService>().navigateToWidget(const OtpView());
  }
}
