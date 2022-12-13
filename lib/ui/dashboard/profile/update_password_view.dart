import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/widget/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widget/button/app_button.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.autoValidateModeEditPassword = AutovalidateMode.disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
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
      body: Form(
        autovalidateMode: authViewModel.autoValidateModeEditPassword,
        key: _formKey,
        child: Container(
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
                  AppTextField(
                    controller: _passwordController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current password';
                      } else if (value.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    textInputType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
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
                  AppTextField(
                    controller: _newPasswordController,
                    hintText: '',
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
                  AppTextField(
                    controller: _confirmPasswordController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password is too short';
                      } else if (value != _newPasswordController.text) {
                        return 'Password mismatch';
                      }
                      return null;
                    },
                    textInputType: TextInputType.visiblePassword,
                    textAlign: TextAlign.center,
                  ),
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          child: AppButton(
                            onTap: () {
                              _passwordUpdated();
                            },
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
      ),
    );
  }

  _passwordUpdated() async {
    final authViewModel = context.read<AuthViewModel>();
    if (_formKey.currentState!.validate()) {
      bool isUpdated = await authViewModel.updatePassword(
          oldPassword: _passwordController.text,
          newPassword: _newPasswordController.text,
          confirmPassword: _confirmPasswordController.text);
      if (isUpdated) {
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
    } else {
      authViewModel.autoValidateModeEditPassword = AutovalidateMode.always;
    }
  }
}
