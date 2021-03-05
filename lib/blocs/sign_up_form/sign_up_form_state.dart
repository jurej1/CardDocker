part of 'sign_up_form_bloc.dart';

class SignUpFormState extends Equatable {
  const SignUpFormState({
    this.displayName = const DisplayName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.isPasswordVisible = false,
  });

  final DisplayName displayName;
  final Email email;
  final Password password;
  final FormzStatus status;
  final bool isPasswordVisible;

  @override
  List<Object> get props {
    return [displayName, email, password, status, isPasswordVisible];
  }

  SignUpFormState copyWith({
    DisplayName? displayName,
    Email? email,
    Password? password,
    FormzStatus? status,
    bool? isPasswordVisible,
  }) {
    return SignUpFormState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
