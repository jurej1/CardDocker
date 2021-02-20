import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String id;
  final String displayName;
  final String email;
  final String photoUrl;

  const UserEntity({
    @required this.id,
    @required this.displayName,
    @required this.email,
    @required this.photoUrl,
  });

  @override
  List<Object> get props => [id, displayName, email, photoUrl];

  @override
  String toString() {
    return 'UserEntity { id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl }';
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  static UserEntity fromJson(Map<String, Object> data) {
    return UserEntity(
      displayName: data['displayName'],
      email: data['email'],
      id: data['id'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  static UserEntity fromDocument(DocumentSnapshot snap) {
    return UserEntity(
      displayName: snap.data()['displayName'],
      email: snap.data()['email'],
      id: snap.id,
      photoUrl: snap.data()['photoUrl'],
    );
  }

  static UserEntity fromFirebaseUser(firebase_auth.User user) {
    return UserEntity(
      displayName: user.displayName,
      email: user.email,
      id: user.uid,
      photoUrl: user.photoURL,
    );
  }
}
