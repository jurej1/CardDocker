part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  const LoginFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.isPasswordVisible = false,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final bool isPasswordVisible;

  @override
  List<Object> get props => [email, password, status, isPasswordVisible];

  @override
  String toString() {
    return 'LoginFormState { email: $email, password: $password, status: $status, isPasswordVisible: $isPasswordVisible }';
  }

  LoginFormState copyWith({
    Email email,
    Password password,
    FormzStatus status,
    bool isPasswordVisible,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
