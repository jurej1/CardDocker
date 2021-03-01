import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';

part 'add_transaction_form_event.dart';
part 'add_transaction_form_state.dart';

class AddTransactionFormBloc extends Bloc<AddTransactionFormEvent, AddTransactionFormState> {
  AddTransactionFormBloc({@required FirebaseTransactionsRepository firebaseTransactionsRepository})
      : _firebaseTransactionsRepository = firebaseTransactionsRepository,
        super(AddTransactionFormState.initial());

  final FirebaseTransactionsRepository _firebaseTransactionsRepository;

  @override
  Stream<AddTransactionFormState> mapEventToState(
    AddTransactionFormEvent event,
  ) async* {
    if (event is TransactionPurposeChanged) {
      yield state.copyWith(purpose: event.purpose);
    } else if (event is TransactionAmountChanged) {
      yield _mapTransactionAmountChangedToState(event);
    } else if (event is TransactionAmountUnfocused) {
      yield _mapTransactionAmountUnfocusedToState();
    } else if (event is TransactionCardIdChanged) {
      yield _mapTransactionCardIdChangedToState(event);
    } else if (event is TransactionTitleChanged) {
      yield _mapTransactionTitleChangedToState(event);
    } else if (event is TransactionTitleUnfocused) {
      yield _mapTransactionTitelUnfocusedToState();
    } else if (event is TransactionNoteChanged) {
      yield _mapTransactionNoteChangedToState(event);
    } else if (event is TransactionSubmitForm) {
      yield* _mapTransactionSubmitFormToState();
    }
  }

  AddTransactionFormState _mapTransactionAmountChangedToState(TransactionAmountChanged event) {
    final balance = Amount.dirty(event.value);

    return state.copyWith(
      balance: balance.valid ? balance : Amount.pure(event.value),
      status: Formz.validate([balance, state.title, state.cardId]),
    );
  }

  AddTransactionFormState _mapTransactionAmountUnfocusedToState() {
    final balance = Amount.dirty(state.balance.value);

    return state.copyWith(
      balance: balance,
      status: Formz.validate([balance, state.title, state.cardId]),
    );
  }

  AddTransactionFormState _mapTransactionCardIdChangedToState(TransactionCardIdChanged event) {
    final cardId = CardId.dirty(event.value);

    return state.copyWith(
      cardId: cardId,
      status: Formz.validate([state.balance, state.title, cardId]),
    );
  }

  AddTransactionFormState _mapTransactionTitleChangedToState(TransactionTitleChanged event) {
    final title = Title.dirty(event.value);

    return state.copyWith(
      status: Formz.validate([state.balance, title, state.cardId]),
      title: title.valid ? title : Title.pure(event.value),
    );
  }

  AddTransactionFormState _mapTransactionTitelUnfocusedToState() {
    final title = Title.dirty(state.title.value);

    return state.copyWith(
      title: title,
      status: Formz.validate([state.balance, title, state.cardId]),
    );
  }

  AddTransactionFormState _mapTransactionNoteChangedToState(TransactionNoteChanged event) {
    final note = Note.dirty(event.value);

    return state.copyWith(
      note: note,
      status: Formz.validate([state.balance, state.title, state.cardId]),
    );
  }

  Stream<AddTransactionFormState> _mapTransactionSubmitFormToState() async* {
    final balance = Amount.dirty(state.balance.value);
    final title = Title.dirty(state.title.value);
    final cardId = CardId.dirty(state.cardId.value);

    yield state.copyWith(
      balance: balance,
      cardId: cardId,
      title: title,
      status: Formz.validate([balance, title, cardId]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        Transaction transaction = Transaction(amount: state.balance.value);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (error) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
