part of 'login_form_bloc.dart';

abstract class LoginFormState extends Equatable {
  const LoginFormState();
  
  @override
  List<Object> get props => [];
}

class LoginFormInitial extends LoginFormState {}
