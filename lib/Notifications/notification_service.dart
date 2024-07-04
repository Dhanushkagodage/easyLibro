import 'dart:convert';
import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Notifications/notification.dart';

class NotificationService {
  Future<bool> setToken(String token, String userName) async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.post(
        'Notification/SetFireBaseToken',
        data: jsonEncode({
          'token': token,
          'userName': userName,
        }),
      );

      if (response.statusCode == 200) {
        
        if (response.data is bool) {
          return response.data;
        } else {
          
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to set token');
      }
    } catch (e) {
      //print('Error setting token: $e');
      throw Exception('Failed to set token: $e');
    }
  }

  Future<List<NotificationDetails>> fetchNotifications() async {
    final apiService = ApiService();
    await apiService.init();

    try {
      final response = await apiService.dio.post(
        'Notification/GetMyNotificatons',
      );
      //print(response.data);
      if (response.statusCode == 200) {
        if (response.data is List) {
          return response.data.map<NotificationDetails>((json) => NotificationDetails.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }

      } else {
        throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
     // print('Error fetching notifications: $e');
      throw Exception('Failed to fetch notifications: $e');
    }
  }
}

class MyNotifications{
  List<NotificationDetails> allNotifications = [];
  NotificationService notificationService = NotificationService();

  Future<void> fetchNotifications() async {
    allNotifications = await notificationService.fetchNotifications();
  }
}