import 'package:beep/core/model/city_model.dart';
import 'package:beep/core/service/api_url.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/ui/auth/login_view.dart';
import 'package:beep/ui/auth/signup_complete.dart';
import 'package:beep/ui/widget/app_debug_print.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ui/auth/otp_view.dart';
import '../../ui/auth/referral_view.dart';
import '../../ui/dashboard/dashboard_view.dart';
import '../app_locator.dart';
import '../service/api_service.dart';
import '../service/navigation_service.dart';
import '../service/shared_pref_service.dart';

class AuthViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final _sharedPrefService = locator<SharedPrefService>();
  final _navigationService = locator<NavigationService>();
  late Data _selectedCity;
  List<Data> cityList = [];
  bool _isReferralApplied = false;
  bool _checkTandC = false;
  bool isLoggedIn = false;

  bool get isReferralApplied => _isReferralApplied;

  // login
  AutovalidateMode _autoValidateModeLogin = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateModeSignUp = AutovalidateMode.disabled;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  String _otpCodeInput = '';

  String get otpCodeInput => _otpCodeInput;

  set otpCodeInput(String value) {
    _otpCodeInput = value;
    notifyListeners();
  }

  Data get selectedCity => _selectedCity;

  set selectedCity(Data value) {
    _selectedCity = value;
    notifyListeners();
  }

  bool get obscureText2 => _obscureText2;

  set obscureText2(bool value) {
    _obscureText2 = value;
    notifyListeners();
  }

  bool get obscureText1 => _obscureText1;

  set obscureText1(bool value) {
    _obscureText1 = value;
    notifyListeners();
  }

  set isReferralApplied(bool value) {
    _isReferralApplied = value;
    notifyListeners();
  }

  bool get checkTandC => _checkTandC;

  set checkTandC(bool value) {
    _checkTandC = value;
    notifyListeners();
  }

  AutovalidateMode get autoValidateModeSignUp => _autoValidateModeSignUp;

  set autoValidateModeSignUp(AutovalidateMode value) {
    _autoValidateModeSignUp = value;
    notifyListeners();
  }

  get autoValidateModeLogin => _autoValidateModeLogin;

  set autoValidateModeLogin(value) {
    _autoValidateModeLogin = value;
    notifyListeners();
  }

  checkLogin() async {
    final token = await _sharedPrefService.getStringKey(
        key: SharedPrefService.token, defValue: '');
    isLoggedIn = false;
    if (token.isNotEmpty) {
      isLoggedIn = true;
    }
    notifyListeners();
  }

  logout() async {
    await _sharedPrefService.setStringKey(
        key: SharedPrefService.token, value: "");
    isLoggedIn = false;
    notifyListeners();
    _navigationService.navigateAndRemoveWidget(const LoginView());
  }

  checkLoginAndNavigate() async {
    await checkLogin();
    if (isLoggedIn) {
      _navigationService.navigateAndRemoveWidget(const DashboardView());
    } else {
      _navigationService.navigateAndRemoveWidget(const LoginView());
    }
  }

  login({required String email, required String password}) async {
    setStatus(ViewStatus.loading);
    final params = {"email": email, "password": password};
    final response = await apiService.post(ApiUrl.login, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      await _sharedPrefService.setStringKey(
          key: SharedPrefService.token, value: response['token']);
      _navigationService.navigateAndRemoveWidget(const DashboardView());
    }
  }

  createAccount(
      {required String fName,
      required String lName,
      required String cityId,
      required String phoneNumber,
      required String email,
      required String password}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "first_name": fName,
      "last_name": lName,
      "city_id": cityId,
      "email": email,
      "phone_no": phoneNumber,
      "password": password
    };
    final response = await apiService.post(ApiUrl.createAccount, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      await _sharedPrefService.setStringKey(
          key: SharedPrefService.verificationToken,
          value: response['verification_token']);
      await _sharedPrefService.setStringKey(
          key: SharedPrefService.resendToken, value: response['resend_token']);
      _navigationService.navigateToWidget(OtpView(phoneNumber: phoneNumber));
    }
  }

  otpVerification() async {
    setStatus(ViewStatus.loading);
    appDebugPrint("otpCodeInput ${otpCodeInput}");
    appDebugPrint(
        "verificationToken ${await _sharedPrefService.getStringKey(key: SharedPrefService.verificationToken, defValue: "")}");
    final params = {
      "otp": otpCodeInput,
      "verification_token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.verificationToken, defValue: "")
    };
    final response = await apiService.post(ApiUrl.otpVerification, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      await _sharedPrefService.setStringKey(
          key: SharedPrefService.token, value: response['token']);
      _navigationService.navigateToWidget(const ReferralView());
    }
  }

  resendOtp() async {
    setStatus(ViewStatus.loading);
    final params = {
      "resend_token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.resendToken, defValue: "")
    };
    final response = await apiService.post(ApiUrl.resendOtp, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
  }

  applyReferralCode({required String referralCode}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "referral_code": referralCode,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("applyReferralCode params $params");
    final response = await apiService.post(ApiUrl.applyReferralCode, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      isReferralApplied = !isReferralApplied;
    }
    notifyListeners();
  }

  submitSignup() async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    final response = await apiService.post(ApiUrl.submitSignup, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _navigationService.navigateToWidget(const SignupComplete());
    }
  }

  addMachine({required String qrCode}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "qr_code": qrCode,
      "token": _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    final response = await apiService.post(ApiUrl.addMachine, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _sharedPrefService.setStringKey(
          key: SharedPrefService.token, value: response['token']);
      _navigationService.navigateToWidget(const ReferralView());
    }
  }

  getCities() async {
    setStatus(ViewStatus.loading);
    final response = await apiService.get(ApiUrl.getCities);
    cityList.clear();
    selectedCity = Data(cityName: '-Select City-');
    cityList.add(selectedCity);
    appDebugPrint('getCities $response');
    if (response["code"] == 200) {
      CityModel city = CityModel.fromJson(response);
      cityList.addAll(city.data!);
    }
    setStatus(ViewStatus.ready);
    notifyListeners();
  }
}
