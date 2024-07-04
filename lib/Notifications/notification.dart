class NotificationDetails {
  final int id;
  final String userName;
  final String subject;
  final String description;
  final int ago;
  final String status;

  NotificationDetails({
    required this.id,
    required this.userName,
    required this.subject,
    required this.description,
    required this.ago,
    required this.status,
  });

  factory NotificationDetails.fromJson(Map<String, dynamic> json) {
    return NotificationDetails(
      id: json['id'],
      userName: json['userName'],
      subject: json['subject'],
      description: json['description'],
      ago: json['ago'],
      status: json['status'],
    );
  }
}
