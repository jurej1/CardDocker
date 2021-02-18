import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final String photoUrl;
  final String email;

  const User({
    String id,
    String photoUrl,
    this.displayName,
    this.email,
  })  : photoUrl = photoUrl,
        id = id;

  @override
  List<Object> get props => [id, displayName, photoUrl, email];

  @override
  String toString() {
    return 'User { id: $id, displayName: $displayName, photoUrl: $photoUrl, email: $email }';
  }

  User copyWith({
    String id,
    String displayName,
    String photoUrl,
    String email,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      displayName: displayName,
      email: email,
      id: id,
      photoUrl: photoUrl,
    );
  }

  static User fromEntity(UserEntity userEntity) {
    return User(
      displayName: userEntity.displayName,
      email: userEntity.email,
      id: userEntity.id,
      photoUrl: userEntity.photoUrl,
    );
  }
}
