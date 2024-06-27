
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource_details.dart';

class ApiService {
  static http.Client getHttpClient() {
    final ioc = HttpClient();
    ioc.badCertificateCallback = 
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  static Future<List<Resource>> fetchResources(String keyword, String tag, String type) async {
    final client = getHttpClient();
    final response = await client.post(
      Uri.parse('https://10.0.2.2:7174/api/Resource/SearchResources'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'keyword': keyword,
        'tag': tag,
        'type': type,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Resource.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load resources');
    }
  }


  static Future<ResourceDetails> fetchResourceDetails(String isbn) async {
  final client = getHttpClient();
  final uri = Uri.parse('https://10.0.2.2:7174/api/Resource/AbouteResource?isbn=$isbn');

  try {
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isbn': isbn}),
    );
    
    
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return ResourceDetails.fromJson(body);
    } else {
      throw Exception('Failed to load resource details. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching resource details: $e');
    throw Exception('Failed to load resource details: $e');
  }
}

}



// import 'dart:convert';
// import 'package:http/http.dart' as https;
// import 'package:easylibro_app/Resources/API/Models/resource.dart';
// import 'package:easylibro_app/Resources/API/Models/resource_details.dart';

// class ApiService {
  

//   static Future<List<Resource>> fetchResources(String keyword, String tag, String type) async {
    
//     final response = await https.post(
//       Uri.parse('https://lms20240616161754.azurewebsites.net/api/Resource/SearchResources'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'keyword': keyword,
//         'tag': tag,
//         'type': type,
//       }),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//       return body.map((dynamic item) => Resource.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load resources');
//     }
//   }


//   static Future<ResourceDetails> fetchResourceDetails(String isbn) async {
  
//   final uri = Uri.parse('https://lms20240616161754.azurewebsites.net/api/Resource/AbouteResource?isbn=$isbn');

//   try {
//     final response = await https.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'isbn': isbn}),
//     );
    
    
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = jsonDecode(response.body);
//       return ResourceDetails.fromJson(body);
//     } else {
//       throw Exception('Failed to load resource details. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error fetching resource details: $e');
//     throw Exception('Failed to load resource details: $e');
//   }
// }

// }
