import 'dart:convert';
import 'dart:io';
import 'package:easylibro_app/User/userdetails.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class UserService {
  static http.Client getHttpClient() {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  static Future<UserDetails> fetchUserDetails(String userName) async {
    final client = getHttpClient();
    try {
      final response = await client.post(
        Uri.parse('https://10.0.2.2:7174/api/User/AboutUser'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userName': userName,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        return UserDetails.fromJson(body);
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      throw Exception('Failed to load user details: $e');
    }
  }
}
