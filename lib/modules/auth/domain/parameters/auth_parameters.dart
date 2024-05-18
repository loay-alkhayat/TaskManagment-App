class AuthParameters {
  final String userName;
  final String password;
  final int? expiresInMins;

  AuthParameters(
      {required this.userName, required this.password, this.expiresInMins});

  Map<String, dynamic> toJson() => {
        'username': userName,
        'password': password,
        'expiresInMins': expiresInMins ?? 30,
      };
}
