import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/User/userdetails.dart';


class UserService {
  
  Future<UserDetails> fetchUserDetails() async {
    final apiService = ApiService();
    await apiService.init();
    try{
      final response = await apiService.dio.post(
        'User/GetMyData',
      );
      print(response.data);
      if(response.statusCode == 200){
        Map<String, dynamic> body = response.data;
        return UserDetails.fromJson(body);
      }else{
        throw Exception('Failed to load user details. Status code: ${response.statusCode}');
      }
    }catch(e){
      //print('Error fetching user details: $e');
      throw Exception('Failed to load user details: $e');
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    final apiService = ApiService();
    await apiService.init();
    try{
      final response = await apiService.dio.put(
        'User/ChangePassword',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword
        }
      );
      print(response.data);
      if(response.statusCode == 200){
        return true;
      }else{
        throw Exception('Failed to change password. Status code: ${response.statusCode}');
      }
    }catch(e){
      //print('Error changing password: $e');
      throw Exception('Failed to change password: $e');
    }
  }
}
