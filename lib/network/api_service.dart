import 'dart:developer';
import 'dart:io';
import 'package:api_calling/network/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../main.dart';

import 'api_config.dart';

enum RequestMethod {
  POST,
  GET,
  PUT,
  PATCH,
  DELETE,
}

class ApiService {
  static late CancelToken cancelToken;

  static Future<ResponseModel> request(String path,
      {required RequestMethod method,
      data,
      queryParameters,
      bool formData = false,
      Function(int, int)? onSendProgress}) async {
    // log('${box.get(HiveKeys.authToken)}');
    // log('method: ${describeEnum(method)}');
    // log('url: $path');
    // log('queryParameters: $queryParameters');
    // log('data: $data');
    try {
      // ApiConfig().dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + box.get(HiveKeys.authToken, defaultValue: '');
      ApiConfig().dio.options.method = describeEnum(method);
      cancelToken = CancelToken();

      Response response = await ApiConfig().dio.request(
            path,
            data: data == null
                ? null
                : formData
                    ? FormData.fromMap(data)
                    : data,
            queryParameters: queryParameters,
            // onSendProgress: (int sent, int total) {
            //   print('$sent $total');
            // },
            cancelToken: cancelToken,
          );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return ResponseModel.fromJson(response.data);
      }

      // BaseHelper.showSnackBar('${response.statusCode}');
    } on DioError catch (e) {
      log("$path >>>>> ${e.response}");
      log("${e.response?.statusCode}");
      // BaseHelper.showSnackBar('${e.response?.data?['message'] ?? '${e.response}'}');
    } on SocketException catch (_) {
      // BaseHelper.showSnackBar('No internet connection'.tr);
    }

    throw Null;
  }

  static Future<void> myRequest(String path, String token,
      {required RequestMethod method}) async {
    var dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    try {
      Response response = await dio.request(path);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.statusCode.toString());
      }
    } catch (e) {
      print("====$e===");
    }
  }

}
