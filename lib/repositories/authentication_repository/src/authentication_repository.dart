import 'models/user.dart';

abstract class AuthenticationRepository {
  Future<void> logInWithEmailAndPassword({String email, String password});

  Future<void> registerWithEmailAndPassword({String email, String password});

  Future<void> authenticateWithGoogle();

  Future<void> logout();

  Stream<User> get user;
}
