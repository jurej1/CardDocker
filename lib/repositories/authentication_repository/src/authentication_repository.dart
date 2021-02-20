import 'package:meta/meta.dart';

import 'models/user.dart';

abstract class AuthenticationRepository {
  Future<void> logInWithEmailAndPassword({@required String email, @required String password});

  Future<void> signUpWithEmailAndPassword({@required String email, @required String password});

  Future<void> updateDisplayName({@required String displayName});

  Future<void> authenticateWithGoogle();

  Future<void> logout();

  Stream<User> get user;
}
