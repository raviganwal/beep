import 'package:beep/core/model/messages_model.dart';
import 'package:beep/core/model/notifications_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
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
  List<NotificationData> notificationsList = [];
  int _page = 1;
  int _pageNotification = 1;

  int get pageNotification => _pageNotification;

  set pageNotification(int value) {
    _pageNotification = value;
    notifyListeners();
  }

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  clearMessageList() {
    messagesList.clear();
    page = 1;
  }

  clearNotificationList() {
    notificationsList.clear();
    pageNotification = 1;
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

  getNotifications() async {
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
    };
    appDebugPrint("getNotifications params $params");
    final response = await apiService.post(
        "${ApiUrl.getNotifications}${'?page=$pageNotification'}", params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      NotificationsModel notificationsModel =
          NotificationsModel.fromJson(response);
      if (notificationsModel.data != null &&
          notificationsModel.data!.isNotEmpty) {
        notificationsList.addAll(notificationsModel.data!);
        pageNotification++;
      }
    }
    notifyListeners();
  }

  markAsNotified({required NotificationData notification}) async {
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
      "notif_id": "${notification.id}"
    };
    appDebugPrint("markAsNotified params $params");
    final response = await apiService.post(ApiUrl.markAsNotified, params);
    if(response['code']==200) {
      Fluttertoast.showToast(msg: response['msg']);
    }
  }
}
