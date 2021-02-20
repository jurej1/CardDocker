import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/models/display_name.dart';
import 'package:card_docker/models/email.dart';
import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc({FirebaseAuthenticationRepository firebaseAuthenticationRepository})
      : assert(firebaseAuthenticationRepository != null),
        _firebaseAuthenticationRepository = firebaseAuthenticationRepository,
        super(SignUpFormState());

  final FirebaseAuthenticationRepository _firebaseAuthenticationRepository;

  @override
  Stream<SignUpFormState> mapEventToState(
    SignUpFormEvent event,
  ) async* {
    if (event is DisplayNameChanged) {
      yield _mapDisplayNameChangedToState(event);
    } else if (event is DisplayNameUnfocused) {
      yield _mapDisplayNameUnfocusedToState();
    } else if (event is SignUpEmailChanged) {
      yield _mapSignUpEmailChangedToState(event);
    } else if (event is SignUpEmailUnfocused) {
      yield _mapSignUpEmailUnfocusedToState();
    } else if (event is SignUpPasswordChanged) {
      yield _mapSignUpPasswordChangedToState(event);
    } else if (event is SignUpPasswordUnfocused) {
      yield _mapSignUpPasswordUnfocusedToState();
    } else if (event is SignUpFormSubmit) {
      yield* _mapSignUpFormSubmitToState();
    }
  }

  SignUpFormState _mapDisplayNameChangedToState(DisplayNameChanged event) {
    final displayName = DisplayName.dirty(event.value);

    return state.copyWith(
      displayName: displayName.valid ? displayName : DisplayName.pure(event.value),
      status: Formz.validate([displayName, state.email, state.password]),
    );
  }

  SignUpFormState _mapDisplayNameUnfocusedToState() {
    final displayName = DisplayName.dirty(state.displayName.value);

    return state.copyWith(
      displayName: displayName,
      status: Formz.validate([displayName, state.email, state.password]),
    );
  }

  SignUpFormState _mapSignUpEmailChangedToState(SignUpEmailChanged event) {
    final email = Email.dirty(event.value);

    return state.copyWith(
      email: email.valid ? email : Email.pure(event.value),
      status: Formz.validate([email, state.password, state.displayName]),
    );
  }

  SignUpFormState _mapSignUpEmailUnfocusedToState() {
    final email = Email.dirty(state.email.value);

    return state.copyWith(
      email: email,
      status: Formz.validate([email, state.password, state.displayName]),
    );
  }

  SignUpFormState _mapSignUpPasswordChangedToState(SignUpPasswordChanged event) {
    final password = Password.dirty(event.value);

    return state.copyWith(
      password: password.valid ? password : Password.pure(event.value),
      status: Formz.validate([password, state.email, state.displayName]),
    );
  }

  SignUpFormState _mapSignUpPasswordUnfocusedToState() {
    final password = Password.dirty(state.password.value);

    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email, state.displayName]),
    );
  }

  Stream<SignUpFormState> _mapSignUpFormSubmitToState() async* {
    final password = Password.dirty(state.password.value);
    final email = Email.dirty(state.email.value);
    final displayName = DisplayName.dirty(state.displayName.value);

    yield state.copyWith(
      displayName: displayName,
      email: email,
      password: password,
      status: Formz.validate([password, email, displayName]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _firebaseAuthenticationRepository.signUpWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );

        await _firebaseAuthenticationRepository.updateDisplayName(
          displayName: state.displayName.value,
        );

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
