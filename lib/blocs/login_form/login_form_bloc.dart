import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc({required FirebaseAuthenticationRepository firebaseAuthenticationRepository})
      : _firebaseAuthenticationRepository = firebaseAuthenticationRepository,
        super(LoginFormState());

  late final FirebaseAuthenticationRepository _firebaseAuthenticationRepository;

  @override
  Stream<LoginFormState> mapEventToState(
    LoginFormEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event);
    } else if (event is EmailUnfocused) {
      yield* _mapEmailUnfocuesToState();
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event);
    } else if (event is PasswordUnfocused) {
      yield* _mapPasswordUnfocusedToState();
    } else if (event is LoginFormSubmit) {
      yield* _mapLoginFormSubmitToState();
    } else if (event is ChangePasswordVisibility) {
      yield _mapChangePasswordVisibilityToState();
    }
  }

  Stream<LoginFormState> _mapEmailChangedToState(EmailChanged event) async* {
    final email = Email.dirty(event.value);

    yield state.copyWith(
      email: email.valid ? email : Email.pure(email.value),
      status: Formz.validate([email, state.password]),
    );
  }

  Stream<LoginFormState> _mapPasswordChangedToState(PasswordChanged event) async* {
    final password = Password.dirty(event.value);

    yield state.copyWith(
      password: password.valid ? password : Password.pure(event.value),
      status: Formz.validate([state.email, state.password]),
    );
  }

  Stream<LoginFormState> _mapLoginFormSubmitToState() async* {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    yield state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    );

    if (state.status.isValidated) {
      try {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        await _firebaseAuthenticationRepository.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  LoginFormState _mapChangePasswordVisibilityToState() => state.copyWith(isPasswordVisible: !state.isPasswordVisible);

  Stream<LoginFormState> _mapEmailUnfocuesToState() async* {
    final email = Email.dirty(state.email.value);

    yield state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  Stream<LoginFormState> _mapPasswordUnfocusedToState() async* {
    final password = Password.dirty(state.password.value);

    yield state.copyWith(
      password: password,
      status: Formz.validate([state.email, state.password]),
    );
  }
}
