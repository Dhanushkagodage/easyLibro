// ignore_for_file: file_names

class Reservation {
  final int reservationNo;
  final String resource;
  final String userName;
  final String userID;
  final String borrowName;
  final String issueDate;
  final String dueDate;
  final String status;

  Reservation({
    required this.reservationNo,
    required this.resource,
    required this.userName,
    required this.userID,
    required this.borrowName,
    required this.issueDate,
    required this.dueDate,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationNo: json['reservationNo'] ?? 0,
      resource: json['resource'] ?? '',
      userName: json['userName'] ?? '',
      userID: json['userID'] ?? '',
      borrowName: json['borrowName'] ?? '',
      issueDate: json['issueDate'] ?? '',
      dueDate: json['dueDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
