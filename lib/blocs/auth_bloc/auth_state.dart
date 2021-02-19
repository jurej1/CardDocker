part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState extends Equatable {
  const AuthState({
    this.user = User.empty,
    this.status = AuthStatus.unknown,
  });

  final User user;
  final AuthStatus status;

  factory AuthState.initial() {
    return AuthState(
      status: AuthStatus.unknown,
      user: User.empty,
    );
  }

  @override
  List<Object> get props => [user, status];
}
