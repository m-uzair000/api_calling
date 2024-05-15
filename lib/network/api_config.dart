import 'package:dio/dio.dart';

import 'api_paths.dart';

class ApiConfig {
  static final ApiConfig _singleton = ApiConfig._internal();

  factory ApiConfig() => _singleton;

  late Dio dio;

  ApiConfig._internal() {
    //creates the singleton instance
    dio = Dio();
    // Set default configs
    dio.options.baseUrl = ApiPaths.baseURL;
    dio.options.connectTimeout = Duration(minutes: 2);
    dio.options.receiveTimeout = Duration(minutes: 2);
  }
  
  
}
