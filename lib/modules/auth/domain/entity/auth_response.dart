class AuthResponse {
  final String token;
  final String
      id; // Assuming this is some identifier associated with the authenticated user

  AuthResponse({required this.token, required this.id});
}
