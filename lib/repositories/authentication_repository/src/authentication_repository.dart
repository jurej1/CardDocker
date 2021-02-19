import 'models/user.dart';

abstract class AuthenticationRepository {
  Future<void> logInWithEmailAndPassword({String email, String password});

  Future<void> registerWithEmailAndPassword({String email, String password});

  Future<void> authenticateWithGoogle();

  Stream<User> get user;
}
