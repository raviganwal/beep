import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/assigned_model.dart';
import 'package:beep/core/model/machine_issues_model.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/model/machine_stats_model.dart';
import 'package:beep/core/model/machine_team_model.dart';
import 'package:beep/core/model/report_options_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

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
  List<Machine> filteredMachineList = [];
  List<Machine> filteredAttentionsList = [];
  List<TeamMembers> machineTeamList = [];
  List<Issue> issuesList = [];
  List<Review> reviewsList = [];
  List<DailyStats> dailyStatsList = [];
  List<MonthlyStats> monthlyStatsList = [];
  List<ReportOption> reportOptionsList = [];
  bool _isMachineAdded = false;
  bool _flashToggle = false;

  bool _searchOpen = false;

  //Machine
  bool _enableVoice = false;
  bool _enableWaterHeater = false;
  bool _enableFoamHeater = false;
  bool _enableLight = false;
  bool _enablePublicAccess = false;
  bool _enableMaintenance = false;

  late Machine _selectedMahcine;
  late ReportOption _selectedReportOption;

  XFile? _pickedFile;

  XFile? get pickedFile => _pickedFile;

  set pickedFile(XFile? value) {
    _pickedFile = value;
    notifyListeners();
  }

  bool get searchOpen => _searchOpen;

  set searchOpen(bool value) {
    _searchOpen = value;
    if (!searchOpen) {
      filteredAttentionsList = attentionsList;
      filteredMachineList = machineList;
    }
    notifyListeners();
  }

  bool get enableMaintenance => _enableMaintenance;

  set enableMaintenance(bool value) {
    _enableMaintenance = value;
    notifyListeners();
  }

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

  ReportOption get selectedReportOption => _selectedReportOption;

  set selectedReportOption(ReportOption value) {
    _selectedReportOption = value;
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

  machineStatusStr({Machine? machine}) {
    if (machine?.publicAccess == "1") {
      return "Private";
    } else if (machine?.maintenanceMode == "1") {
      return "Maintenance";
    } else {
      return null;
    }
  }

  checkMachineStatus({Machine? machine}) {
    machine ??= selectedMahcine;
    if (machine.err == "0" &&
        machine.maintenanceMode == "0" &&
        machine.foamTank == "0" &&
        machine.waterTank == "0" &&
        (machine.issues == "0")) {
      return MachineStatus.operatesNormally;
    } else if (machine.err == "1") {
      return MachineStatus.offline;
    } else if (machine.err == "0" &&
        (machine.foamTank == "1" ||
            machine.maintenanceMode == "1" ||
            machine.waterTank == "1" ||
            machine.issues != "0")) {
      return MachineStatus.needAttention;
    }
  }

  searchMachine({String? query = ""}) {
    filteredMachineList = machineList
        .where((item) => item.machineName!
            .toLowerCase()
            .contains(query.toString().toLowerCase()))
        .toList();
    filteredAttentionsList = attentionsList
        .where((item) => item.machineName!
            .toLowerCase()
            .contains(query.toString().toLowerCase()))
        .toList();
    notifyListeners();
  }

  getAllMachine({AuthViewModel? authViewModel}) async {
    machineList.clear();
    attentionsList.clear();
    filteredAttentionsList.clear();
    filteredMachineList.clear();
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
      filteredMachineList = machineList;
      filteredAttentionsList = attentionsList;
    } else {
      Fluttertoast.showToast(msg: response['msg']);
      if (authViewModel != null) authViewModel.logout();
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

  getMachineStats() async {
    dailyStatsList.clear();
    monthlyStatsList.clear();
    final params = {
      "machine_id": selectedMahcine.id,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: "")
    };
    appDebugPrint("getMachineStats params $params");
    final response = await apiService.post(ApiUrl.getMachineStats, params);
    if (response["code"] == 200) {
      MachineStatsModel machineStatsModel =
          MachineStatsModel.fromJson(response);
      dailyStatsList.addAll(machineStatsModel.dailyStats!);
      monthlyStatsList.addAll(machineStatsModel.monthlyStats!);
    }
    notifyListeners();
  }

  addMachine({required String qrCode}) async {
    setStatus(ViewStatus.loading);
    isMachineAdded = false;
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
      isMachineAdded = true;
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

  saveMachineSettings(
      {required String machineName,
      required String address,
      required String cityId}) async {
    reviewsList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "machine_id": selectedMahcine.id,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      // "is_active": enablePublicAccess ? "1" : "0",
      "water_heater": enableWaterHeater ? "0" : "1",
      "foam_heater": enableFoamHeater ? "0" : "1",
      "foam_tank": selectedMahcine.foamTank,
      "water_tank": selectedMahcine.waterTank,
      "light": enableLight ? "0" : "1",
      "voice": enableVoice ? "0" : "1",
      "machine_name": machineName,
      "address": address,
      "city_id": cityId,
      "state": placemark?.administrativeArea ?? selectedMahcine.state,
      "country": placemark?.country ?? selectedMahcine.country,
      "postal_code": placemark?.postalCode ?? selectedMahcine.postalCode,
      "machine_lat": currentPosition?.latitude ?? selectedMahcine.machineLat,
      "machine_long": currentPosition?.longitude ?? selectedMahcine.machineLong,
      "public_access": enablePublicAccess ? "0" : "1",
      "maintenance_mode": enableMaintenance ? "1" : "0",
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

  getMachineTeam() async {
    machineTeamList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": selectedMahcine.id
    };
    appDebugPrint("getMachineList params $params");
    final response = await apiService.post(ApiUrl.getMachineTeam, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MachineTeamModel machineTeamModel = MachineTeamModel.fromJson(response);
      machineTeamList.addAll(machineTeamModel.teamMembers!);
    } else {
      Fluttertoast.showToast(msg: response['msg']);
    }
    notifyListeners();
  }

  getReportOptions() async {
    reportOptionsList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
    };
    appDebugPrint("getReportOptions params $params");
    final response = await apiService.post(ApiUrl.getReportOptions, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      ReportOptionsModel reportOptionsModel =
          ReportOptionsModel.fromJson(response);
      reportOptionsList.addAll(reportOptionsModel.data!);
      selectedReportOption = reportOptionsList.first;
    }
    notifyListeners();
  }

  submitReport({required String comment}) async {
    setStatus(ViewStatus.loading);
    String fileName = pickedFile!.path.split('/').last;
    FormData params = FormData.fromMap({
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "machine_id": selectedMahcine.id,
      "issue_id": selectedReportOption.id,
      "comment": comment,
      'attachment':
          await MultipartFile.fromFile(pickedFile!.path, filename: fileName),
    });
    appDebugPrint("submitReport params $params");
    final response = await apiService.post(ApiUrl.submitReport, params);
    setStatus(ViewStatus.ready);
    Fluttertoast.showToast(msg: response['msg']);
  }
}
