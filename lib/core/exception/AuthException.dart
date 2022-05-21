enum TypeAuthException {
  weakPassword,
  operationNotAllowed,
  emailAlreadyInUse,
}

class AuthException implements Exception {
  final TypeAuthException exception;
  const AuthException(this.exception);
}
