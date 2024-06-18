// import 'dart:convert';
// import 'dart:io';
// import 'package:easylibro_app/widgets/resource_details.dart';
// import 'package:http/io_client.dart';
// import 'package:http/http.dart' as http;
// import 'package:easylibro_app/widgets/resource.dart';

// class ApiService {
//   static http.Client getHttpClient() {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//     return IOClient(ioc);
//   }

//   static Future<List<Resource>> fetchResources() async {
//     final client = getHttpClient();
//     final response = await client
//         .get(Uri.parse('https://10.0.2.2:5164/api/Resource/SearchResources'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Resource.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load resources');
//     }
//   }

// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:easylibro_app/widgets/resource_details.dart';
// import 'package:http/io_client.dart';
// import 'package:http/http.dart' as http;
// import 'package:easylibro_app/widgets/resource.dart';

// class ApiService {
//   static http.Client getHttpClient() {
//     final ioc = HttpClient();
//     ioc.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//     return IOClient(ioc);
//   }

//   static Future<List<Resource>> fetchResources(
//       String keyword, String tag, String type) async {
//     final client = getHttpClient();
//     final response = await client.post(
//       Uri.parse('http://10.0.2.2:5164/api/Resource/SearchResources'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'keyword': keyword,
//         'tag': tag,
//         'type': type,
//       }),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//       List<Resource> resources =
//           body.map((dynamic item) => Resource.fromJson(item)).toList();
//       return resources;
//     } else {
//       throw Exception('Failed to load resources');
//     }
//   }

//   static Future<ResourceDetails> fetchResourceDetails(String isbn) async {
//     final client = getHttpClient();
//     final response = await client.get(Uri.parse('http://10.0.2.2:5164/api/Resource/AbouteResource?isbn=$isbn'));

//     if(response.statusCode == 200) {
//       return ResourceDetails.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load resource details');
//     }
//   }
  
// }


import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:easylibro_app/widgets/resource.dart';
import 'package:easylibro_app/widgets/resource_details.dart';

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
      Uri.parse('http://10.0.2.2:5164/api/Resource/SearchResources'),
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

  // static Future<ResourceDetails> fetchResourceDetails(String isbn) async {
  //   final client = getHttpClient();
  //   final response = await client.get(
  //     Uri.parse('http://10.0.2.2:5164/api/Resource/AbouteResource?isbn=$isbn'),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> body = jsonDecode(response.body);
  //     return ResourceDetails.fromJson(body);
  //   } else {
  //     throw Exception('Failed to load resource details');
  //   }
  // }

  static Future<ResourceDetails> fetchResourceDetails(String isbn) async {
  final client = getHttpClient();
  final uri = Uri.parse('http://10.0.2.2:5164/api/Resource/AbouteResource?isbn=$isbn');

  try {
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isbn': isbn}),
    );
    
    // Log the full response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return ResourceDetails.fromJson(body);
    } else {
      throw Exception('Failed to load resource details. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Log the error for better debugging
    print('Error fetching resource details: $e');
    throw Exception('Failed to load resource details: $e');
  }
}

}
