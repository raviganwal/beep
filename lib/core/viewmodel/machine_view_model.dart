import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/assigned_model.dart';
import 'package:beep/core/model/machine_issues_model.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../ui/widget/app_debug_print.dart';
import '../app_locator.dart';
import '../model/machine_reviews_model.dart';
import '../service/api_service.dart';
import '../service/api_url.dart';
import '../service/shared_pref_service.dart';

enum MachineStatus { operatesNormally, offline, needAttention }

class MachineViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final _sharedPrefService = locator<SharedPrefService>();

  Position? _currentPosition;
  Placemark? _placemark;

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateModeSettings = AutovalidateMode.disabled;

  List<Machine> machineList = [];
  List<Machine> attentionsList = [];
  List<AssignedModel> assignedList = [];
  List<Issue> issuesList = [];
  List<Review> reviewsList = [];
  bool _isMachineAdded = false;
  bool _flashToggle = false;

  //Machine
  bool _enableVoice = false;
  bool _enableWaterHeater = false;
  bool _enableFoamHeater = false;
  bool _enableLight = false;
  bool _enablePublicAccess = false;

  late Machine _selectedMahcine;

  Placemark? get placemark => _placemark;

  set placemark(Placemark? value) {
    _placemark = value;
    notifyListeners();
  }

  Position? get currentPosition => _currentPosition;

  set currentPosition(Position? value) {
    _currentPosition = value;
    notifyListeners();
  }

  Machine get selectedMahcine => _selectedMahcine;

  set selectedMahcine(Machine value) {
    _selectedMahcine = value;
    notifyListeners();
  }

  bool get isMachineAdded => _isMachineAdded;

  set isMachineAdded(bool value) {
    _isMachineAdded = value;
    notifyListeners();
  }

  bool get flashToggle => _flashToggle;

  set flashToggle(bool value) {
    _flashToggle = value;
    notifyListeners();
  }

  bool get enableVoice => _enableVoice;

  set enableVoice(bool value) {
    _enableVoice = value;
    notifyListeners();
  }

  bool get enableWaterHeater => _enableWaterHeater;

  set enableWaterHeater(bool value) {
    _enableWaterHeater = value;
    notifyListeners();
  }

  bool get enableFoamHeater => _enableFoamHeater;

  set enableFoamHeater(bool value) {
    _enableFoamHeater = value;
    notifyListeners();
  }

  bool get enableLight => _enableLight;

  set enableLight(bool value) {
    _enableLight = value;
    notifyListeners();
  }

  bool get enablePublicAccess => _enablePublicAccess;

  set enablePublicAccess(bool value) {
    _enablePublicAccess = value;
    notifyListeners();
  }

  AutovalidateMode get autoValidateModeSettings => _autoValidateModeSettings;

  set autoValidateModeSettings(AutovalidateMode value) {
    _autoValidateModeSettings = value;
    notifyListeners();
  }

  AutovalidateMode get autoValidateMode => _autoValidateMode;

  set autoValidateMode(AutovalidateMode value) {
    _autoValidateMode = value;
    notifyListeners();
  }

  checkMachineStatus({Machine? machine}) {
    machine ??= selectedMahcine;
    if (machine.isActive == "1" &&
        machine.foamTank == "0" &&
        machine.waterTank == "0" &&
        machine.waterHeater == "0" &&
        machine.foamHeater == "0" &&
        machine.light == "0" &&
        machine.voice == "0" &&
        (machine.issues == "0")) {
      return MachineStatus.operatesNormally;
    } else if (machine.isActive == "0") {
      return MachineStatus.offline;
    } else if (machine.isActive == "1" &&
        (machine.foamTank == "1" ||
            machine.waterTank == "1" ||
            machine.waterHeater == "1" ||
            machine.foamHeater == "1" ||
            machine.light == "1" ||
            machine.voice == "1" ||
            machine.issues != "0")) {
      return MachineStatus.needAttention;
    }
  }

  getAllMachine({AuthViewModel? authViewModel}) async {
    machineList.clear();
    attentionsList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("getAllMachine params $params");
    final response = await apiService.post(ApiUrl.getMachines, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MachineModel machineModel = MachineModel.fromJson(response);
      for (Machine machine in machineModel.data!) {
        if (checkMachineStatus(machine: machine) ==
            MachineStatus.operatesNormally) {
          machineList.add(machine);
        } else {
          attentionsList.add(machine);
        }
      }
    } else {
      Fluttertoast.showToast(msg: response['msg']);
      if (authViewModel == null) authViewModel?.logout();
    }
    notifyListeners();
  }

  getMachineDetail() async {
    setStatus(ViewStatus.loading);
    final params = {
      "machine_id": selectedMahcine.id,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("getMachineDetail params $params");
    final response = await apiService.post(ApiUrl.getMachineDetail, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      selectedMahcine = Machine.fromJson(response['data']);
    }
    notifyListeners();
  }

  addMachine({required String qrCode}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "qr_code": qrCode,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("getAllMachine params $params");
    final response = await apiService.post(ApiUrl.addMachine, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    if (response["code"] == 200) {
      isMachineAdded = !isMachineAdded;
    }
    notifyListeners();
    getAllMachine();
  }

  getIssues() async {
    issuesList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "machine_id": selectedMahcine.id,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("getIssues params $params");
    final response = await apiService.post(ApiUrl.getMachineIssues, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      IssuesModel issuesModel = IssuesModel.fromJson(response);
      issuesList.addAll(issuesModel.data!);
    } else {
      Fluttertoast.showToast(msg: response['msg']);
    }
    notifyListeners();
  }

  //Mark an Issue as fixed
  markAsFix({required String issueId}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "issue_id": issueId,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("markAsFix params $params");
    final response = await apiService.post(ApiUrl.markAsFixed, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    int updateIndex = issuesList.indexWhere((element) => element.id == issueId);

    /// status == "0" not fixed
    /// status == "1" fixed
    issuesList[updateIndex].status = "1";
    notifyListeners();
  }

  getMachineReviews() async {
    reviewsList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "machine_id": selectedMahcine.id,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("getAllMachine params $params");
    final response = await apiService.post(ApiUrl.getMachineReviews, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MachineReviewsModel machineReviewsModel =
      MachineReviewsModel.fromJson(response);
      reviewsList.addAll(machineReviewsModel.data!);
    } else {
      Fluttertoast.showToast(msg: response['msg']);
    }
    notifyListeners();
  }

  saveMachineSettings({required String machineName,
    required String address,
    required String cityId}) async {
    reviewsList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "machine_id": selectedMahcine.id,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "is_active": enablePublicAccess ? "1" : "0",
      "water_heater": enableWaterHeater ? "0" : "1",
      "foam_heater": enableFoamHeater ? "0" : "1",
      "foam_tank": selectedMahcine.foamTank,
      "water_tank": selectedMahcine.waterTank,
      "light": enableLight ? "0" : "1",
      "voice": enableVoice ? "0" : "1",
      "machine_name": machineName,
      "address": address,
      "city_id": cityId,
      "state": placemark?.administrativeArea,
      "country": placemark?.country,
      "postal_code": placemark?.postalCode,
      "machine_lat": currentPosition?.latitude,
      "machine_long": currentPosition?.longitude
    };

    appDebugPrint("saveMachineSettings params $params");
    final response = await apiService.post(ApiUrl.saveMachineSettings, params);
    appDebugPrint("saveMachineSettings response  ${response.toString()}");
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
    notifyListeners();
    getMachineDetail();
    getAllMachine();
  }

  getAssignedList() {
    assignedList.clear();
    assignedList.add(AssignedModel(
      "Ray Alexander",
      "Operator - Machine 1",
      "example@email.com",
      "+12344567584",
    ));
    assignedList.add(AssignedModel(
      "Sean Justin",
      "Techinician",
      "example@email.com",
      "+12344567584",
    ));
    notifyListeners();
  }
}
