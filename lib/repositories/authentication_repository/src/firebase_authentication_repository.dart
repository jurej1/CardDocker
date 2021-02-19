import 'authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<void> logInWithEmailAndPassword({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (error) {
      throw LoginWithEmailAndPasswordException(error.toString());
    }
  }

  @override
  Future<void> registerWithEmailAndPassword({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception catch (error) {
      throw RegisterWithEmailAndPasswordException(error.toString());
    }
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
}

class AuthenticateWithGoogleException implements Exception {
  const AuthenticateWithGoogleException(this.error);
  final String error;
  @override
  String toString() => error;
}

class LoginWithEmailAndPasswordException implements Exception {
  const LoginWithEmailAndPasswordException(this.error);

  final String error;

  @override
  String toString() => toString();
}

class RegisterWithEmailAndPasswordException implements Exception {
  const RegisterWithEmailAndPasswordException(this.error);

  final String error;

  @override
  String toString() => error;
}
