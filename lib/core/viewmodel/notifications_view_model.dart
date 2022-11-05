import 'package:beep/core/model/assigned_model.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/model/messages_model.dart';
import 'package:beep/core/model/notification_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ui/widget/app_debug_print.dart';
import '../app_locator.dart';
import '../service/api_service.dart';
import '../service/api_url.dart';
import '../service/shared_pref_service.dart';

class NotificationsViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final _sharedPrefService = locator<SharedPrefService>();
  List<Message> messagesList = [];
  List<Message> notificationsList = [];
  int _page = 1;

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  clearNotificationList() {
    messagesList.clear();
    page = 1;
  }

  getMessages() async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
    };
    appDebugPrint("getNotifications params $params");
    final response =
        await apiService.post("${ApiUrl.getMessages}${'?page=$page'}", params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      MessagesModel notificationsModel = MessagesModel.fromJson(response);
      if (notificationsModel.data != null &&
          notificationsModel.data!.isNotEmpty) {
        messagesList.addAll(notificationsModel.data!);
        page++;
      }
    }
    notifyListeners();
  }
}
