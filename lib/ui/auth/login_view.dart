import 'package:beep/core/app_validators.dart';
import 'package:beep/ui/auth/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../../core/viewmodel/auth_view_model.dart';
import '../widget/button/app_button.dart';
import '../widget/rich_text/signup_rich_text.dart';
import '../widget/textfield/app_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.autoValidateModeLogin = AutovalidateMode.disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
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
                autovalidateMode: authViewModel.autoValidateModeLogin,
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    const SizedBox(
                      height: 58,
                    ),
                    Image.asset(
                      "assets/png/logo.png",
                      width: 165,
                      height: 63,
                    ),
                    const SizedBox(
                      height: 106,
                    ),
                    Text(
                      'Login to your Account',
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
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!value.isValidEmail()) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      obscureText: !authViewModel.obscureText,
                      hintText: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 6) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      textInputType: TextInputType.visiblePassword,
                      textAlign: TextAlign.center,
                      suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose  vbghthe icon
                            authViewModel.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF898989),
                          ),
                          onPressed: () {
                            authViewModel.obscureText =
                                !authViewModel.obscureText;
                          }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // Figma Flutter Generator ButtonregularlargeWidget - INSTANCE
                    AppButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authViewModel.login(
                              email: _emailController.text,
                              password: _passwordController.text);
                        } else {
                          authViewModel.autoValidateModeLogin =
                              AutovalidateMode.always;
                        }
                      },
                      title: "Sign In",
                    ),
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 60),
                            child: SignupRichText(
                              onTap: () {
                                _goToSignUp();
                              },
                            ))
                        : const SizedBox()
                  ],
                ),
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: SignupRichText(
                        onTap: () {
                          _goToSignUp();
                        },
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _goToSignUp() async {
    await locator<NavigationService>().navigateToWidget(const SignupView());
  }
}
