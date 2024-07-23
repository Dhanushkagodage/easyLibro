import 'package:easylibro_app/API_Service/api_service.dart';

class DashboardService {
  Future<Map<String, dynamic>> fetchDashboardData() async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.post(
        'Dashboard/getDashboradData',
      );
      // print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }

   Future<List<String>> fetchAnnoucement()async{
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.post(
        'Dashboard/getAnouncement',
      );
      print(response.data);
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
   }
}
