import 'package:flutter/material.dart';

enum ViewStatus { ready, loading }

class BaseViewModel extends ChangeNotifier {
  ViewStatus _status = ViewStatus.ready;

  ViewStatus get status => _status;

  void setStatus(ViewStatus value) {
    _status = value;
    notifyListeners();
  }

  /// 1= operator, 2 = Manager and 3= Technician
  getUserRole({required String role}) {
    switch (role) {
      case "1":
        {
          return "Operator";
        }
      case "2":
        {
          return "Technician";
        }
      case "3":
        {
          return "Technician";
        }
      default:
        return "";
    }
  }

}
