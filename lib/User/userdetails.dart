

class UserDetails{

  final String userName;
  final String fName;
  final String lName;
  final String userType;
  final String email;
  final String actualType;
  final String phone;
  final String dob;
  final String address;
  final String status;
  final String nic;
  final int reservationcount;

  const UserDetails({
    required this.userName,
    required this.fName,
    required this.lName,
    required this.userType,
    required this.email,
    required this.actualType,
    required this.phone,
    required this.dob,
    required this.address,
    required this.status,
    required this.nic,
    required this.reservationcount,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userName: json['userName'],
      fName: json['fName'],
      lName: json['lName'],
      userType: json['userType'],
      email: json['email'],
      actualType: json['actualType'],
      phone: json['phone'],
      dob: json['dob'],
      address: json['address'],
      status: json['status'],
      nic: json['nic'],
      reservationcount: json['reservationcount'],
    );
  }

}