class Reservationdetails {

  final int resId;
  final String isbn;
  final String bookTitle;
  final String userName;
  final String dateIssue; 
  final String dueDate;
  final String issuer;
  final String returnDate;
  final String status;
  final String imagePath;
  final int penalty;

  Reservationdetails({
    required this.resId,
    required this.isbn,
    required this.bookTitle,
    required this.userName,
    required this.dateIssue,
    required this.dueDate,
    required this.issuer,
    required this.returnDate,
    required this.status,
    required this.imagePath,
    required this.penalty,
  });

  factory Reservationdetails.fromJson(Map<String, dynamic> json) {
    return Reservationdetails(
      resId: json['resId'] ?? 0,
      isbn: json['isbn'] ?? '',
      bookTitle: json['bookTitle'] ?? '',
      userName: json['userName'] ?? '',
      dateIssue: json['dateIssue'] ?? '',
      dueDate: json['dueDate'] ?? '',
      issuer: json['issuer'] ?? '',
      returnDate: json['returnDate'] ?? '',
      status: json['status'] ?? '',
      imagePath: json['imagePath'] ?? '',
      penalty: json['penalty'] ?? '',
    );
  }
}
