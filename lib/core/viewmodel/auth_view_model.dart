import 'package:beep/core/model/city_model.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/model/my_team_machine_model.dart';
import 'package:beep/core/model/my_team_model.dart';
import 'package:beep/core/model/profile_model.dart';
import 'package:beep/core/model/user_role_model.dart';
import 'package:beep/core/service/api_url.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/ui/auth/login_view.dart';
import 'package:beep/ui/auth/signup_complete.dart';
import 'package:beep/ui/widget/app_debug_print.dart';
import 'package:country_picker/country_picker.dart';
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
  late Machines _selectedMachine;
  late Machines _selectedAssignedToMachine;
  late UserRoleModel _selectedUserRole;
  List<UserRoleModel> roleList = [];
  List<Data> cityList = [];
  List<Machines> myTeamMachineList = [];
  List<Machines> assignToList = [];
  List<TeamMembers> myTeamList = [];
  bool _isReferralApplied = false;
  bool _checkTandC = false;
  bool isLoggedIn = false;
  ProfileModel? profileModel;

  Country _selectedCountryCountry = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: -1,
    geographic: false,
    level: -1,
    name: 'United States',
    example: '',
    displayName: 'World Wide (WW)',
    displayNameNoCountryCode: 'World Wide',
    e164Key: '',
  );

  UserRoleModel get selectedUserRole => _selectedUserRole;

  set selectedUserRole(UserRoleModel value) {
    _selectedUserRole = value;
    notifyListeners();
  }

  Country get selectedCountryCountry => _selectedCountryCountry;

  set selectedCountryCountry(Country value) {
    _selectedCountryCountry = value;
    notifyListeners();
  }

  bool get isReferralApplied => _isReferralApplied;

  // login
  AutovalidateMode _autoValidateModeLogin = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateModeSignUp = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateModeEditProfile = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateModeEditPassword = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateModeAddTeamMember = AutovalidateMode.disabled;

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  String _otpCodeInput = '';

  String get otpCodeInput => _otpCodeInput;

  set otpCodeInput(String value) {
    _otpCodeInput = value;
    notifyListeners();
  }

  Machines get selectedAssignedToMachine => _selectedAssignedToMachine;

  set selectedAssignedToMachine(Machines value) {
    _selectedAssignedToMachine = value;
    notifyListeners();
  }

  Machines get selectedMachine => _selectedMachine;

  set selectedMachine(Machines value) {
    _selectedMachine = value;
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

  AutovalidateMode get autoValidateModeAddTeamMember =>
      _autoValidateModeAddTeamMember;

  set autoValidateModeAddTeamMember(AutovalidateMode value) {
    _autoValidateModeAddTeamMember = value;
    notifyListeners();
  }

  AutovalidateMode get autoValidateModeEditPassword =>
      _autoValidateModeEditPassword;

  set autoValidateModeEditPassword(AutovalidateMode value) {
    _autoValidateModeEditPassword = value;
    notifyListeners();
  }

  AutovalidateMode get autoValidateModeEditProfile =>
      _autoValidateModeEditProfile;

  set autoValidateModeEditProfile(AutovalidateMode value) {
    _autoValidateModeEditProfile = value;
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

  // 1= operator, 2 = Manager and 3= Technician
  getRoleList() {
    roleList.clear();
    selectedUserRole = UserRoleModel("0", "-Select-");
    roleList.add(selectedUserRole);
    roleList.add(UserRoleModel("1", "Operator"));
    roleList.add(UserRoleModel("2", "Manager"));
    roleList.add(UserRoleModel("3", "Technician"));
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
      "phone_no": '+${selectedCountryCountry.phoneCode}$phoneNumber',
      "password": password
    };
    appDebugPrint('createAccount params $params');
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

  profile() async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
    };
    appDebugPrint("profile params $params");
    final response = await apiService.post(ApiUrl.profile, params);
    setStatus(ViewStatus.ready);
    profileModel = ProfileModel.fromJson(response);
    notifyListeners();
  }

  updateProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String bankName,
      required String accountNumber,
      required String accountTile}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "bank_name": bankName,
      "account_number": accountNumber,
      "account_title": accountTile,
    };
    appDebugPrint("profile params $params");
    final response = await apiService.post(ApiUrl.updateProfile, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    profile();
    notifyListeners();
  }

  updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "old_password": oldPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    };
    appDebugPrint("profile params $params");
    final response = await apiService.post(ApiUrl.updatePassword, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      return true;
    } else {
      return false;
    }
  }

  getMyTeam({String machineId = "0"}) async {
    myTeamList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": machineId
    };
    appDebugPrint("getMachineList params $params");
    final response = await apiService.post(ApiUrl.myTeam, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MyTeamModel machineTeamModel = MyTeamModel.fromJson(response);
      myTeamList.addAll(machineTeamModel.teamMembers!);
    } else {
      Fluttertoast.showToast(msg: response['msg']);
    }
    notifyListeners();
  }

  getAssignTo({String machineId = "0"}) async {
    setStatus(ViewStatus.loading);
    assignToList.clear();
    selectedAssignedToMachine = Machines(machineName: '-Select-', id: "0");
    assignToList.add(selectedAssignedToMachine);

    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": machineId
    };
    appDebugPrint("getMachineList params $params");
    final response = await apiService.post(ApiUrl.getMachineOptions, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MyTeamMachineModel myTeamMachineModel =
          MyTeamMachineModel.fromJson(response);
      assignToList.addAll(myTeamMachineModel.machines!);
    } else {
      Fluttertoast.showToast(msg: response['msg']);
    }
    notifyListeners();
  }

  getMachineOptions(
      {String machineId = "0", bool fromAddMemberScreen = false}) async {
    setStatus(ViewStatus.loading);
    myTeamMachineList.clear();
    selectedMachine = Machines(machineName: 'All Member', id: "0");
    myTeamMachineList.add(selectedMachine);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": machineId
    };
    appDebugPrint("getMachineList params $params");
    final response = await apiService.post(ApiUrl.getMachineOptions, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MyTeamMachineModel myTeamMachineModel =
          MyTeamMachineModel.fromJson(response);
      myTeamMachineList.addAll(myTeamMachineModel.machines!);
    } else {
      Fluttertoast.showToast(msg: response['msg']);
    }
    notifyListeners();
  }

  addTeamMember(
      {required String firstName,
      required String lastName,
      required phoneNo,
      required email,
      required password}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": selectedAssignedToMachine.id,
      "first_name": firstName,
      "last_name": lastName,
      "phone_no": phoneNo,
      "email": email,
      "password": password,
      "user_role": selectedUserRole.id,
    };
    appDebugPrint("getMachineList params $params");
    final response = await apiService.post(ApiUrl.addTeamMember, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _navigationService.popAwait(key: 'key', value: true);
    }
  }

  updateTeamMember(
      {required String memberId,
      required String firstName,
      required String lastName,
      required phoneNo,
      required email}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": selectedAssignedToMachine.id,
      "member_id": memberId,
      "first_name": firstName,
      "last_name": lastName,
      "phone_no": phoneNo,
      "email": email,
      "user_role": selectedUserRole.id,
    };
    appDebugPrint("updateTeamMember params $params");
    final response = await apiService.post(ApiUrl.updateTeamMember, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _navigationService.popAwait(key: 'key', value: true);
    }
  }

  deleteTeamMember({required String memberId}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "member_id": memberId,
    };
    appDebugPrint("updateTeamMember params $params");
    final response = await apiService.post(ApiUrl.deleteTeamMember, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      _navigationService.popAwait(key: 'key', value: true);
    }
  }
}
