import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class TeamViewModel extends BaseViewModel {
  List<String> roleList = <String>['-Select-'];
  List<String> assignToList = <String>['-Select-'];
  late String _selectedRole, _selectedAssignTo;

  TeamViewModel() {
    selectedRole = roleList.first;
    selectedAssignTo = assignToList.first;
  }

  get selectedAssignTo => _selectedAssignTo;

  set selectedAssignTo(value) {
    _selectedAssignTo = value;
    notifyListeners();
  }

  String get selectedRole => _selectedRole;

  set selectedRole(String value) {
    _selectedRole = value;
    notifyListeners();
  }
}
