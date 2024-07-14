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
      // print(response.data);
      if (response.statusCode == 200) {
        if (response.data is List) {
          return response.data
              .map<NotificationDetails>(
                  (json) => NotificationDetails.fromJson(json))
              .toList();
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  Future<bool> markAsRead(int id) async {
    final apiService = ApiService();
    await apiService.init();

    try {
      final response = await apiService.dio.get(
        'Notification/MarkAsRead',
        queryParameters: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        if (response.data is bool) {
          return response.data;
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to mark as read');
      }
    } catch (e) {
      throw Exception('Failed to mark as read: $e');
    }
  }

  Future<int> getUnreadNotificationsCount() async {
    final apiService = ApiService();
    await apiService.init();

    try {
      final response = await apiService.dio.post(
        'Notification/UnreadCount',
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data is int) {
          return response.data;
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to get unread notifications count');
      }
    } catch (e) {
      throw Exception('Failed to get unread notifications count: $e');
    }
  }
}

class MyNotifications {
  List<NotificationDetails> allNotifications = [];
  NotificationService notificationService = NotificationService();

  Future<void> fetchNotifications() async {
    allNotifications = await notificationService.fetchNotifications();
  }
}
