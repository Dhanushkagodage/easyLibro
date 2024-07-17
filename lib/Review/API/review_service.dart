import 'package:easylibro_app/API_Service/api_service.dart';
import 'package:easylibro_app/Review/API/review.dart';


class ReviewService{
  Future<List<Review>> fetchReviews(String isbn) async{
    final apiService = ApiService();
    await apiService.init();
    try{
      final response = await apiService.dio.get(
        'Review/GetBookReviews?isbn=$isbn',
        
      );
      //print(response.data);
      if(response.statusCode == 200){
        List<dynamic> body = response.data;
        return body.map((dynamic item) => Review.fromJson(item)).toList();
      }else{
        throw Exception('Failed to load reviews');
      }
    }catch(e){
      throw Exception('Failed to load reviews: $e');
    }

  }
}

