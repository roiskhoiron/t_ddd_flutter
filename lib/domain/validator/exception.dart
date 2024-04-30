// Exception untuk validasi input
class UsernameEmptyException implements Exception {
  @override
  String toString() => 'Username cannot be empty';
}

class PasswordEmptyException implements Exception {
  @override
  String toString() => 'Password cannot be empty';
}

class InvalidCredentialsException implements Exception {
  @override
  String toString() => 'Invalid username or password';
}

class UserNotFoundException implements Exception {
  @override
  String toString() => 'User not found';
}
