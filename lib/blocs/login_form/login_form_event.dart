part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginFormEvent {
  final String value;

  const EmailChanged(this.value);

  @override
  List<Object> get props => [value];
}

class PasswordChanged extends LoginFormEvent {
  final String value;

  const PasswordChanged(this.value);

  @override
  List<Object> get props => [value];
}

class LoginFormSubmit extends LoginFormEvent {}
