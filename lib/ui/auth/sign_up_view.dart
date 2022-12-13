import 'package:beep/core/app_validators.dart';
import 'package:beep/core/model/city_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/auth/otp_view.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.getCities();
      authViewModel.autoValidateModeSignUp = AutovalidateMode.disabled;
      authViewModel.checkTandC = false;
      authViewModel.obscureText1 = true;
      authViewModel.obscureText2 = true;
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
                autovalidateMode: authViewModel.autoValidateModeSignUp,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    Image.asset(
                      "assets/png/logo.png",
                      width: 165,
                      height: 63,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Create your Account',
                      style: GoogleFonts.nunitoSans(
                          color: const Color(0xFF212121),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      controller: _fNameController,
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
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _lNameController,
                      hintText: "Last Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: const Color(0xFFEAEAEA),
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Theme(
                        // <- Here
                        data: Theme.of(context).copyWith(
                          // <- Here
                          splashColor: Colors.transparent, // <- Here
                          highlightColor: Colors.transparent, // <- Here
                          hoverColor: Colors.transparent, // <- Here
                        ),
                        child: authViewModel.cityList.isEmpty
                            ? const SizedBox()
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<Data>(
                                  value: authViewModel.selectedCity,
                                  icon: SvgPicture.asset(
                                      'assets/svg/arrow-down-icon.svg'),
                                  elevation: 16,
                                  // style: GoogleFonts.nunitoSans(
                                  //   color:
                                  //       authViewModel.selectedCity.cityName ==
                                  //               '-Select-'
                                  //           ? const Color(0xff898989)
                                  //           : const Color(0xff212121),
                                  // ),
                                  onChanged: (Data? value) {
                                    // This is called when the user selects an item.
                                    authViewModel.selectedCity = value!;
                                  },
                                  items: authViewModel.cityList
                                      .map<DropdownMenuItem<Data>>(
                                          (Data value) {
                                    return DropdownMenuItem<Data>(
                                      value: value,
                                      child: Text(
                                        value.cityName.toString(),
                                        style: GoogleFonts.nunitoSans(
                                          color:
                                              value.cityName == '-Select City-'
                                                  ? const Color(0xff898989)
                                                  : const Color(0xff212121),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _phoneNumberController,
                      hintText: "Phone Number",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                      textInputType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      prefixIcon: SizedBox(
                        width: 90,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                    favorite: <String>['US', 'IN', 'PK'],
                                    //Optional. Shows phone code before the country name.
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      print(
                                          'Select country: ${country.displayName}');
                                      authViewModel.selectedCountryCountry =
                                          country;
                                    },
                                    // Optional. Sets the theme for the country list picker.
                                    countryListTheme: CountryListThemeData(
                                      // Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      // Optional. Styles the search field.
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xFF8C98A8)
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                      // Optional. Styles the text in the search field
                                      searchTextStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "+${authViewModel.selectedCountryCountry.phoneCode}",
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF212121)),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(
                                        'assets/svg/arrow-down-icon.svg')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                      obscureText: authViewModel.obscureText1,
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
                            authViewModel.obscureText1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF898989),
                          ),
                          onPressed: () {
                            authViewModel.obscureText1 =
                                !authViewModel.obscureText1;
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _confirmPasswordController,
                      obscureText: authViewModel.obscureText2,
                      hintText: 'Confirm Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 6) {
                          return 'Password is too short';
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      textInputType: TextInputType.visiblePassword,
                      textAlign: TextAlign.center,
                      suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose  vbghthe icon
                            authViewModel.obscureText2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF898989),
                          ),
                          onPressed: () {
                            authViewModel.obscureText2 =
                                !authViewModel.obscureText2;
                          }),
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
                        if (_formKey.currentState!.validate()) {
                          if (authViewModel.selectedCity.id == null) {
                            Fluttertoast.showToast(
                                msg: 'Please select your city');
                          } else if (!authViewModel.checkTandC) {
                            Fluttertoast.showToast(
                                msg:
                                    'Please accept Terms of Service and Privacy Policy');
                          } else {
                            authViewModel.createAccount(
                              fName: _fNameController.text,
                              lName: _lNameController.text,
                              cityId: authViewModel.selectedCity.id.toString(),
                              phoneNumber: _phoneNumberController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        } else {
                          authViewModel.autoValidateModeSignUp =
                              AutovalidateMode.always;
                        }
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
}
