part of 'sign_up_form_bloc.dart';

abstract class SignUpFormEvent extends Equatable {
  const SignUpFormEvent();

  @override
  List<Object> get props => [];
}

class DisplayNameChanged extends SignUpFormEvent {
  final String value;

  const DisplayNameChanged(this.value);

  @override
  List<Object> get props => [value];
}

class DisplayNameUnfocused extends SignUpFormEvent {}

class SignUpEmailChanged extends SignUpFormEvent {
  final String value;
  const SignUpEmailChanged(this.value);

  @override
  List<Object> get props => [value];
}

class SignUpEmailUnfocused extends SignUpFormEvent {}

class SignUpPasswordChanged extends SignUpFormEvent {
  final String value;
  const SignUpPasswordChanged(this.value);

  @override
  List<Object> get props => [value];
}

class SignUpPasswordUnfocused extends SignUpFormEvent {}

class SignUpFormSubmit extends SignUpFormEvent {}

class SignUpPasswordVisibilityChange extends SignUpFormEvent {}
