import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/User/userdetails.dart';

class UserService {
  Future<UserDetails> fetchUserDetails() async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.post(
        'User/GetMyData',
      );
      //print(response.data);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = response.data;
        return UserDetails.fromJson(body);
      } else {
        throw Exception(
            'Failed to load user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //print('Error fetching user details: $e');
      throw Exception('Failed to load user details: $e');
    }
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.put('User/ChangePassword', data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword
      });
      //print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to change password. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<bool> editUserDetails(String fName, String lName, String dob,
      String address, String phoneNumber, String gender) async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.put('User/EditUser', data: {
        'fName': fName,
        'lName': lName,
        'dob': dob,
        'address': address,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
      //print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to edit user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to edit user details: $e');
    }
  }

  Future<bool> editUserImage(String imageUrl) async {
    final apiService = ApiService();
    await apiService.init();
    try {
      final response = await apiService.dio.put('User/EditProfilePicture?image=$imageUrl');
     // print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to edit user image.');
      }
    } catch (e) {
      throw Exception('Failed to edit user image.');
    }
  }

}
