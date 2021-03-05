import 'dart:async';

import 'package:card_docker/constants/card_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'add_credict_card_form_event.dart';
part 'add_credict_card_form_state.dart';

class AddCredictCardFormBloc extends Bloc<AddCredictCardFormEvent, AddCredictCardFormState> {
  AddCredictCardFormBloc({required FirebaseCredictCardRepository firebaseCredictCardRepository, required AuthBloc authBloc})
      : _firebaseCredictCardRepository = firebaseCredictCardRepository,
        _authCubit = authBloc,
        super(AddCredictCardFormState.initial());

  final FirebaseCredictCardRepository _firebaseCredictCardRepository;
  final AuthBloc _authCubit;

  @override
  Stream<AddCredictCardFormState> mapEventToState(
    AddCredictCardFormEvent event,
  ) async* {
    if (event is CredictCardCompanyChanged) {
      yield state.copyWith(company: event.company);
    } else if (event is CredictCardAmountChanged) {
      yield _mapCredictCardAmountChangedToState(event);
    } else if (event is CredictCardAmountUnfocused) {
      yield _mapCredictCardAmountUnfocused();
    } else if (event is CredictCardTypeChanged) {
      yield state.copyWith(type: event.type);
    } else if (event is CredictCardNoteChanged) {
      yield _mapCredictCardNoteChangedToState(event);
    } else if (event is CredictCardNoteUnfocused) {
      yield _mapCredictCardUnfocusedToState();
    } else if (event is CredictCardColorChanged) {
      yield state.copyWith(color: event.color);
    } else if (event is CrediCardFormSubmit) {
      yield* _mapCredictCardFormSubmitToState();
    }
  }

  AddCredictCardFormState _mapCredictCardAmountChangedToState(CredictCardAmountChanged event) {
    final balance = Amount.dirty(event.value);

    return state.copyWith(
      balance: balance.valid ? balance : Amount.pure(event.value),
      status: Formz.validate([balance, state.note]),
    );
  }

  AddCredictCardFormState _mapCredictCardAmountUnfocused() {
    final balance = Amount.dirty(state.balance.value);

    return state.copyWith(
      balance: balance,
      status: Formz.validate([balance, state.note]),
    );
  }

  AddCredictCardFormState _mapCredictCardNoteChangedToState(CredictCardNoteChanged event) {
    final note = Note.dirty(event.value);

    return state.copyWith(
      note: note.valid ? note : Note.pure(event.value),
      status: Formz.validate([state.balance, note]),
    );
  }

  AddCredictCardFormState _mapCredictCardUnfocusedToState() {
    final note = Note.dirty(state.note.value);

    return state.copyWith(
      note: note,
      status: Formz.validate([state.balance, note]),
    );
  }

  Stream<AddCredictCardFormState> _mapCredictCardFormSubmitToState() async* {
    final note = Note.dirty(state.note.value);
    final balance = Amount.dirty(state.balance.value);

    yield state.copyWith(
      note: note,
      balance: balance,
      status: Formz.validate([balance, note]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final credictCard = CredictCard(
          note: state.note.value,
          ownerId: (_authCubit.state as Authenticated).user.id,
          balance: double.parse(state.balance.value),
          color: state.color,
          company: state.company,
          type: state.type,
        );

        await _firebaseCredictCardRepository.addCredictCard(credictCard);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (error) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
