import 'package:flutter/material.dart';

enum ViewStatus { ready, loading }

class BaseViewModel extends ChangeNotifier {
  ViewStatus _status = ViewStatus.ready;

  ViewStatus get status => _status;

  void setStatus(ViewStatus value) {
    _status = value;
    notifyListeners();
  }
}
