class TokenRequest {
  final String token;
  final String userName;

  TokenRequest({required this.token, required this.userName});

  factory TokenRequest.fromJson(Map<String, dynamic> json) {
    return TokenRequest(
      token: json['token'],
      userName: json['userName'],
    );
  }
}
