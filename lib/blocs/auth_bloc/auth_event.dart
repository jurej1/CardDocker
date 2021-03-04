part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthStatusUpdated extends AuthEvent {
  final User? user;

  const AuthStatusUpdated(this.user);

  @override
  List<Object> get props => [user!];
}

class LogoutRequested extends AuthEvent {}
