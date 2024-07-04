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
}
