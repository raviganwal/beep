import 'package:beep/core/service/api_url.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ui/dashboard/dashboard_view.dart';
import '../app_locator.dart';
import '../service/api_service.dart';
import '../service/navigation_service.dart';
import '../service/shared_pref_service.dart';

class AuthViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final _sharedPrefService = locator<SharedPrefService>();
  final _navigationService = locator<NavigationService>();
  bool _isReferralApplied = false;
  bool _checkTandC = false;

  bool get isReferralApplied => _isReferralApplied;

  // login
  AutovalidateMode _autoValidateModeLogin = AutovalidateMode.disabled;
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
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

  get autoValidateModeLogin => _autoValidateModeLogin;

  set autoValidateModeLogin(value) {
    _autoValidateModeLogin = value;
    notifyListeners();
  }

  login({required String email, required String password}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "email": "muhammadwaqasamjad@gmail.com",
      "password": "123456"
    };
    final response = await apiService.post(ApiUrl.login, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _sharedPrefService.setBoolKey(
          key: SharedPrefService.isLoggedIn, value: true);
      _sharedPrefService.setStringKey(
          key: SharedPrefService.token, value: response['token']);
      _navigationService.navigateAndRemoveWidget(const DashboardView());
    }
  }

  createAccount(
      {required String fName,
      required String lName,
      required String phoneNumber,
      required String email,
      required String password}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "first_name": fName,
      "last_name": lName,
      "email": email,
      "phone_no": phoneNumber,
      "password": password
    };
    final response = await apiService.post(ApiUrl.createAccount, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _sharedPrefService.setStringKey(
          key: SharedPrefService.verificationToken, value: response['verification_token']);
      _sharedPrefService.setStringKey(
          key: SharedPrefService.resendToken, value: response['resend_token']);
      _navigationService.navigateAndRemoveWidget(const DashboardView());
    }
  }
}
