import 'package:easylibro_app/Review/API/review_service.dart';

class Review{
  final int id;
  final String isbn;
  final String description;
  final int stars;
  final String username;
  final String userId;
  final String imageUrl;

   Review({
    required this.id,
    required this.isbn,
    required this.description,
    required this.stars,
    required this.username,
    required this.userId,
    required this.imageUrl,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      isbn: json['isbn'],
      description: json['description'],
      stars: json['stars'],
      username: json['username'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
    );
  }
}

class MyReviews{
  List<Review> allReviews = [];
  ReviewService reviewService = ReviewService();

  Future<double> fetchRating(String isbn) async {
    allReviews = await reviewService.fetchReviews(isbn);
    double rating = 0;
    if (allReviews.isEmpty) {
      return 0;
    }
    for (int i = 0; i < allReviews.length; i++) {
      rating += allReviews[i].stars;
    }
    
    return rating = rating / allReviews.length;
  }
  
  Future<void>fetchReviews(String isbn) async {
    allReviews = await reviewService.fetchReviews(isbn);
  }
}