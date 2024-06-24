class AuthRequest {
  final String userName;
  final String password;

  AuthRequest({required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}

class AuthResponse {
  final String accessToken;
  final String message;

  AuthResponse({required this.accessToken, required this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      message: json['message'],
    );
  }
}
