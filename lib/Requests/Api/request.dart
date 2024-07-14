class Request {
  final int id;
  final String borrowerID;
  final String isbn;
  final String title;
  final String date;

  Request(
      {required this.id,
      required this.borrowerID,
      required this.isbn,
      required this.title,
      required this.date});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      borrowerID: json['borrowerID'],
      isbn: json['isbn'],
      title: json['title'],
      date: json['date'],
    );
  }
}
