import 'package:beep/core/model/assigned_model.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class MachineViewModel extends BaseViewModel {
  List<MachineModel> machineList = [];
  List<MachineModel> attentionsList = [];
  List<AssignedModel> assignedList = [];
  bool _isMachineAdded = false;
  bool _flashToggle = false;

  //Machine
  bool _enableVoice = false;
  bool _enableWaterHeater = false;
  bool _enableFoamHeater = false;
  bool _enableLight = false;
  bool _enablePublicAccess = false;

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

  getAllMachine() {
    machineList.clear();
    machineList.add(
        MachineModel(image: "assets/png/machine-logo.png", name: "Machine 1"));
    machineList.add(
        MachineModel(image: "assets/png/machine-logo.png", name: "Machine 2"));
    machineList.add(
        MachineModel(image: "assets/png/machine-logo.png", name: "Machine 3"));
    machineList.add(
        MachineModel(image: "assets/png/machine-logo.png", name: "Machine 4"));
    machineList.add(
        MachineModel(image: "assets/png/machine-logo.png", name: "Machine 5"));
    notifyListeners();
  }

  needAttentions() {
    attentionsList.clear();
    // attentionsList.add(MachineModel(
    //     image: "assets/png/machine-logo.png",
    //     name: "Machine 6",
    //     isOffline: true));
    // attentionsList.add(
    //     MachineModel(image: "assets/png/machine-logo.png", name: "Machine 7"));
    // attentionsList.add(
    //     MachineModel(image: "assets/png/machine-logo.png", name: "Machine 8"));
    // attentionsList.add(
    //     MachineModel(image: "assets/png/machine-logo.png", name: "Machine 9"));
    notifyListeners();
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
