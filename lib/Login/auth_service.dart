// import 'dart:convert';
// import 'package:easylibro_app/Login/auth_request.dart';
// import 'package:http/http.dart' as https;

// class AuthService {
//   final String baseUrl = 'https://lms20240616161754.azurewebsites.net/api/Auth';

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
// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:easylibro_app/Login/auth_request.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/io_client.dart';

// class AuthService {
//   static http.Client getHttpClient() {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//     return IOClient(ioc);
//   }

//   final String baseUrl = 'https://10.0.2.2:7174/api/Auth';

//   Future<AuthResponse> login(AuthRequest request) async {
//     final client = getHttpClient();
//     final response = await client.post(
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
// }


import 'dart:convert';
import 'dart:io';
import 'package:easylibro_app/Login/auth_request.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static http.Client getHttpClient() {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  final String baseUrl = 'https://10.0.2.2:7174/api/Auth';

  Future<AuthResponse> login(AuthRequest request) async {
    final client = getHttpClient();
    final response = await client.post(
      Uri.parse('$baseUrl/mobilelogin'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  Future<void> saveUserData(String userName, String accessToken) async {
    final SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('userName', userName);
    localStorage.setString('accessToken', accessToken);
  }
}