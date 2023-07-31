class AccessToken {
  final String token;
  final DateTime expiresIn;

  const AccessToken({
    required this.token,
    required this.expiresIn
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(token: json['token'], expiresIn: DateTime.parse(json['expiresIn']));
  }
}