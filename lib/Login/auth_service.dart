// import 'dart:convert';
// import 'package:easylibro_app/Login/auth_request.dart';
// import 'package:http/http.dart' as https;
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   final String baseUrl = 'https://easylibrowebapi.azurewebsites.net/api/Auth';

//   Future<AuthResponse> login(AuthRequest request) async {
//     final response = await https.post(
//       Uri.parse('$baseUrl/mobilelogin'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(request.toJson()),
//     );

//     if (response.statusCode == 200) {
//       return AuthResponse.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to authenticate user');
//     }
//   }
//   Future<void> saveUserData(String userName, String accessToken) async {
//     final SharedPreferences localStorage = await SharedPreferences.getInstance();
//     localStorage.setString('userName', userName);
//     localStorage.setString('accessToken', accessToken);
//   }
// }


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Login/auth_request.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = ApiService().dio;

  // final String baseUrl = 'https://easylibrowebapi.azurewebsites.net/api/Auth';

  Future<AuthResponse> login(AuthRequest request) async {
    try {
      final response = await _dio.post(
        'Auth/mobilelogin',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to authenticate user');
      }
    } catch (e) {
      print('Error authenticating user: $e');
      throw Exception('Failed to authenticate user: $e');
    }
  }
  Future<void> saveUserData(String userName, String accessToken) async {
    final SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('userName', userName);
    localStorage.setString('accessToken', accessToken);
  }
}
