import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Requests/Api/request.dart';

class RequestService {
  Future<List<Request>> fetchRequests() async {
    final apiService = ApiService();
    await apiService.init();

    try {
      final response = await apiService.dio.post('Request/DisplayRequest');
      //print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Request.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load requests');
      }
    } catch (e) {
      throw Exception('Failed to load requests: $e');
    }
  }

  Future<bool> addRequest(String isbn) async {
    final apiService = ApiService();
    await apiService.init();

    try {
      final response =
          await apiService.dio.post('Request/RequestResource', data: {
        'isbn': isbn,
      });
      //print(response.data);
      if (response.statusCode == 200) {
        return response.data as bool;
      } else {
        throw Exception("Failed to add request");
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }

  Future<bool> deleteRequest(int id) async {
    final apiService = ApiService();
    await apiService.init();

    try {
      final response = await apiService.dio.delete(
        'Request/RemoveRequest',
        queryParameters: {'id': id},
      );
      // print(response.data);
      if (response.statusCode == 200) {
        return response.data as bool;
      } else {
        throw Exception("Failed to delete request");
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }
}
