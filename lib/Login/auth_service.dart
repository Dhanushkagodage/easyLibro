
import 'package:dio/dio.dart';
import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Login/auth_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = ApiService().dio;


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
