part of 'sign_up_form_bloc.dart';

class SignUpFormState extends Equatable {
  const SignUpFormState({
    this.displayName = const DisplayName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status,
  });

  final DisplayName displayName;
  final Email email;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [displayName, email, password, status];

  SignUpFormState copyWith({
    DisplayName displayName,
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return SignUpFormState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
