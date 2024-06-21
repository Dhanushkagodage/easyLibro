

class Reservation {
  final int reservationNo;
  final String Resource;
  final String UserName;
  final String UserID;
  final String BorrowName;
  final String IssueDate;
  final String DueDate;
  final String Status;

  const Reservation({
    required this.reservationNo,
    required this.Resource,
    required this.UserName,
    required this.UserID,
    required this.BorrowName,
    required this.IssueDate,
    required this.DueDate,
    required this.Status,
  });

}
