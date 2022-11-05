import 'dart:async';

import 'package:beep/ui/widget/app_debug_print.dart';
import 'package:dio/dio.dart';

class ApiService {
  var dio = Dio();

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      appDebugPrint("options.path ${options.path}");
      appDebugPrint("options.baseUrl ${options.baseUrl}");
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));
  }

  Future<dynamic> get(String url, {var params, var headers}) async {
    appDebugPrint(params.toString());
    try {
      Response response = await dio.get(url,
          queryParameters: params,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: headers));
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return e.response;
      }
    }
  }

  Future<dynamic> post(String url, var params, {var headers}) async {
    try {
      Response response = await dio.post(url,
          data: params,
          options: Options(
              // contentType: Headers.formUrlEncodedContentType,
              headers: headers));
      appDebugPrint('responsedata ${response.data}');
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        appDebugPrint('error ${e.response}');
        return e.response;
      }
    }
  }

  Future downloadFile(
      {required String url,
      required String savePath,
      var showDownloadProgress}) async {
    try {
      Response response = await dio.download(url, savePath,
          onReceiveProgress: showDownloadProgress);
      return response;
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      // print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  dynamic requestInterceptor(RequestOptions options) async {
    return options;
  }
}
