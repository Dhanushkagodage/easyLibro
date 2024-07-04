import 'dart:convert';
import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource_details.dart';

class ResourceService {
  Future<List<Resource>> fetchResources(
      String keyword, String tag, String type) async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.post(
        'Resource/SearchResources',
        data: jsonEncode({
          'keyword': keyword,
          'tag': tag,
          'type': type,
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Resource.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load resources');
      }
    } catch (e) {
     // print('Error fetching resources: $e');
      throw Exception('Failed to load resources: $e');
    }
  }

  Future<ResourceDetails> fetchResourceDetails(String isbn) async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.post(
        'Resource/AbouteResource',
        queryParameters: {'isbn': isbn},
        data: jsonEncode({'isbn': isbn}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> body = response.data;
        return ResourceDetails.fromJson(body);
      } else {
        throw Exception(
            'Failed to load resource details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //print('Error fetching resource details: $e');
      throw Exception('Failed to load resource details: $e');
    }
  }
}
