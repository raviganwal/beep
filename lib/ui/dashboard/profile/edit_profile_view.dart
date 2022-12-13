import 'package:beep/core/app_validators.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/dashboard/profile/update_password_view.dart';
import 'package:beep/ui/widget/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/app_locator.dart';
import '../../../core/service/navigation_service.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      if (authViewModel.profileModel != null) {
        _firstNameController.text =
            authViewModel.profileModel!.accountInfo!.firstName!;
        _lastNameController.text =
            authViewModel.profileModel!.accountInfo!.lastName!;
        _emailController.text = authViewModel.profileModel!.accountInfo!.email!;
        _phoneController.text = authViewModel.profileModel!.accountInfo!.phone!;
        _bankNameController.text =
            authViewModel.profileModel!.bankAccount!.bankName!;
        _accountNumberController.text =
            authViewModel.profileModel!.bankAccount!.accountNumber!;
        _accountNameController.text =
            authViewModel.profileModel!.bankAccount!.accountTitle!;
        authViewModel.autoValidateModeEditProfile = AutovalidateMode.disabled;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
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
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    authViewModel.updateProfile(
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        email: _emailController.text.trim(),
                        bankName: _bankNameController.text.trim(),
                        accountNumber: _accountNumberController.text.trim(),
                        accountTile: _accountNameController.text.trim());
                  } else {
                    authViewModel.autoValidateModeEditProfile =
                        AutovalidateMode.always;
                  }
                },
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
      body: Form(
        key: _formKey,
        autovalidateMode: authViewModel.autoValidateModeEditProfile,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 30),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 17, bottom: 30),
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
                  AppTextField(
                    controller: _firstNameController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first Name';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
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
                  AppTextField(
                    controller: _lastNameController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last Name';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
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
                  AppTextField(
                    controller: _emailController,
                    hintText: '',
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
                  AppTextField(
                    controller: _phoneController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
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
                  AppTextField(
                    controller: _passwordController,
                    hintText: "*******",
                    suffixIcon: Container(
                      width: 80,
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
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 17, bottom: 23),
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
                  AppTextField(
                    controller: _bankNameController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter bank name';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
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
                  AppTextField(
                    controller: _accountNumberController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter account number';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
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
                  AppTextField(
                    controller: _accountNameController,
                    hintText: '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter account name';
                      }
                      return null;
                    },
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
