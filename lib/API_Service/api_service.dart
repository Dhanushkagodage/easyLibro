// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   late Dio _dio;
// final SharedPreferences localStorage = SharedPreferences.getInstance();
//     final accessToken = localStorage.getString('accessToken');
//   Future<void> getToken() async {
//     final SharedPreferences localStorage = await SharedPreferences.getInstance();
//     final accessToken = localStorage.getString('accessToken');
//     _dio.options.headers['Authorization'] = 'Bearer $accessToken';
//   }
//   ApiService() {

//     _dio = Dio(BaseOptions(
//       baseUrl: 'https://easylibrowebapi.azurewebsites.net/api/',
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//     ));
//   }
//   Dio get dio => _dio;
// }

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  late Dio _dio;
  late String accessToken;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://easylibrowebapi.azurewebsites.net/api/',
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  Dio get dio => _dio; // Getter for accessing the Dio instance

  Future<void> init() async {
    await setAccessTokenFromLocalStorage();
  }

  Future<void> setAccessTokenFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }
}
