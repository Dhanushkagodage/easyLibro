import 'dart:convert';
import 'dart:io';
import 'package:easylibro_app/widgets/resource_details.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:easylibro_app/widgets/resource.dart';

class ApiService {
  static http.Client getHttpClient() {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  static Future<List<Resource>> fetchResources() async {
    final client = getHttpClient();
    final response = await client
        .get(Uri.parse('https://10.0.2.2:7174/api/Resource/GetAllResource'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Resource.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load resources');
    }
  }

  static Future<ResourceDetails> fetchResourceDetails(String isbn) async {
    final client = getHttpClient();
    final response = await client.get(Uri.parse('https://10.0.2.2:7174/api/Resource/AbouteResource?isbn=$isbn'));

    if (response.statusCode == 200) {
      return ResourceDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load resource');
    }
  }
}
