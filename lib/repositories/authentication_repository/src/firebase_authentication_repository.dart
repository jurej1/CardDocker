import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'authentication_repository.dart';
import 'entities/entities.dart';
import 'models/user.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  Future<void> authenticateWithGoogle() {
    // TODO: implement authenticateWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> logInWithEmailAndPassword({@required String email, @required String password}) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      } else {
        return User.fromEntity(UserEntity.fromFirebaseUser(firebaseUser));
      }
    });
  }

  @override
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> signUpWithEmailAndPassword({@required String email, @required String password}) async {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> updateDisplayName({@required String displayName}) async {
    return _firebaseAuth.currentUser.updateProfile(displayName: displayName);
  }
}
