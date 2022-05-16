abstract class Auth {
  Future<void> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  });
}
