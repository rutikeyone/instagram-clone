abstract class Auth {
  Future<void> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required String? photoUrl,
  });

  Future<void> loginUser({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
