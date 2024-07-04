
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
