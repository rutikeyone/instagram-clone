enum TypeAuthException {
  weakPassword,
  operationNotAllowed,
  emailAlreadyInUse,
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword
}

class AuthException implements Exception {
  final TypeAuthException exception;
  const AuthException(this.exception);
}
