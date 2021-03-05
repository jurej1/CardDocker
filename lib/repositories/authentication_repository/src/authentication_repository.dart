import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart' as model;

abstract class AuthenticationRepository {
  Future<UserCredential> logInWithEmailAndPassword({required String email, required String password});

  Future<UserCredential> signUpWithEmailAndPassword({required String email, required String password});

  Future<void> updateDisplayName({required String displayName});

  Future<void> authenticateWithGoogle();

  Future<void> logout();

  Stream<model.User?> get user;
}
