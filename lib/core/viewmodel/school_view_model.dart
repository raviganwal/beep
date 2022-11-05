import 'package:beep/core/model/assigned_model.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/model/messages_model.dart';
import 'package:beep/core/model/notification_model.dart';
import 'package:beep/core/model/school_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../ui/dashboard/school/search_school_view.dart';
import '../../ui/widget/app_debug_print.dart';
import '../app_locator.dart';
import '../service/api_service.dart';
import '../service/api_url.dart';
import '../service/navigation_service.dart';
import '../service/shared_pref_service.dart';

class SchoolViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final _sharedPrefService = locator<SharedPrefService>();
  final _navigationService = locator<NavigationService>();
  List<Article> articleList = [];
  List<Article> searchArticleList = [];

  getArticles() async {
    articleList.clear();
    setStatus(ViewStatus.loading);
    final params = {
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
    };
    appDebugPrint("getNotifications params $params");
    final response = await apiService.post(ApiUrl.beepSchool, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      SchoolModel schoolModel = SchoolModel.fromJson(response);
      articleList.addAll(schoolModel.data!);
    }
    notifyListeners();
  }

  searchArticles({String query = ""}) async {
    setStatus(ViewStatus.loading);
    final params = {
      "q": query,
      "token": await _sharedPrefService.getStringKey(
          key: SharedPrefService.token, defValue: ""),
    };
    appDebugPrint("searchArticles params $params");
    final response = await apiService.post(ApiUrl.searchBeepSchool, params);
    setStatus(ViewStatus.ready);
    if (response["code"] == 200) {
      SchoolModel schoolModel = SchoolModel.fromJson(response);
      searchArticleList.clear();
      searchArticleList.addAll(schoolModel.data!);
    }
    notifyListeners();
  }

  navigateSearchView() {
    _navigationService.navigateToWidgetFade(const SearchSchoolView());
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: Duration(milliseconds: 300),
    //     pageBuilder: (BuildContext context, Animation<double> animation,
    //         Animation<double> secondaryAnimation) {
    //       return const SearchSchoolView();
    //     },
    //     transitionsBuilder: (BuildContext context, Animation<double> animation,
    //         Animation<double> secondaryAnimation, Widget child) {
    //       return Align(
    //         child: FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
