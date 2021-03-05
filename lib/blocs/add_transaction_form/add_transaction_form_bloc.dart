import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart' as repository;

part 'add_transaction_form_event.dart';
part 'add_transaction_form_state.dart';

class AddTransactionFormBloc extends Bloc<AddTransactionFormEvent, AddTransactionFormState> {
  AddTransactionFormBloc({
    required repository.FirebaseTransactionsRepository firebaseTransactionsRepository,
    required AuthBloc authBloc,
    required AddTransactionFormState initialState,
  })   : _firebaseTransactionsRepository = firebaseTransactionsRepository,
        _authBloc = authBloc,
        super(initialState);

  final repository.FirebaseTransactionsRepository _firebaseTransactionsRepository;
  final AuthBloc _authBloc;

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
    } else if (event is TransactionCardChanged) {
      yield _mapTransactionCardIdChangedToState(event);
    } else if (event is TransactionTitleChanged) {
      yield _mapTransactionTitleChangedToState(event);
    } else if (event is TransactionTitleUnfocused) {
      yield _mapTransactionTitelUnfocusedToState();
    } else if (event is TransactionNoteChanged) {
      yield _mapTransactionNoteChangedToState(event);
    } else if (event is TransactionSubmitForm) {
      yield* _mapTransactionSubmitFormToState();
    } else if (event is TransactionCreatedChanged) {
      yield _mapTransactionChangedToState(event);
    }
  }

  AddTransactionFormState _mapTransactionAmountChangedToState(TransactionAmountChanged event) {
    final amount = Amount.dirty(event.value);

    return state.copyWith(
      amount: amount.valid ? amount : Amount.pure(event.value),
      status: Formz.validate([amount, state.title, state.card, state.created]),
    );
  }

  AddTransactionFormState _mapTransactionAmountUnfocusedToState() {
    final amount = Amount.dirty(state.amount.value);
    return state.copyWith(
      amount: amount,
      status: Formz.validate([amount, state.title, state.card, state.created]),
    );
  }

  AddTransactionFormState _mapTransactionCardIdChangedToState(TransactionCardChanged event) {
    final card = CardId.dirty(event.card);

    return state.copyWith(
      card: card,
      status: Formz.validate([state.amount, state.title, card, state.created]),
    );
  }

  AddTransactionFormState _mapTransactionTitleChangedToState(TransactionTitleChanged event) {
    final title = Title.dirty(event.value);

    return state.copyWith(
      status: Formz.validate([state.amount, title, state.card, state.created]),
      title: title.valid ? title : Title.pure(event.value),
    );
  }

  AddTransactionFormState _mapTransactionTitelUnfocusedToState() {
    final title = Title.dirty(state.title.value);

    return state.copyWith(
      title: title,
      status: Formz.validate([state.amount, title, state.card, state.created]),
    );
  }

  AddTransactionFormState _mapTransactionNoteChangedToState(TransactionNoteChanged event) {
    final note = Note.dirty(event.value);

    return state.copyWith(
      note: note,
      status: Formz.validate([state.amount, state.title, state.card, state.created]),
    );
  }

  AddTransactionFormState _mapTransactionChangedToState(TransactionCreatedChanged event) {
    final created = Created.dirty(event.value);

    return state.copyWith(
      created: created,
      status: Formz.validate([created, state.amount, state.title, state.card]),
    );
  }

  Stream<AddTransactionFormState> _mapTransactionSubmitFormToState() async* {
    final amount = Amount.dirty(state.amount.value);
    final title = Title.dirty(state.title.value);
    final card = CardId.dirty(state.card.value);
    final created = Created.dirty(state.created.value);

    yield state.copyWith(
      amount: amount,
      created: created,
      card: card,
      title: title,
      status: Formz.validate([amount, title, card, created]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        if (state.mode == Mode.add) {
          yield await _addTransaction();
        } else if (state.mode == Mode.edit) {
          yield await _editTransaction();
        }
      } catch (error) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Future<AddTransactionFormState> _addTransaction() async {
    try {
      final user = (_authBloc.state as Authenticated).user;

      repository.Transaction transaction = repository.Transaction(
        amount: num.parse(state.amount.value),
        cardId: state.card.value.id!,
        note: state.note.value,
        ownerId: user.id!,
        title: state.title.value,
        purpose: state.purpose!,
        created: Timestamp.fromDate(state.created.value),
      );

      await _firebaseTransactionsRepository.addTransaction(transaction);

      return state.copyWith(
        status: FormzStatus.submissionSuccess,
        transaction: transaction,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<AddTransactionFormState> _editTransaction() async {
    try {
      final oldTransaction = state.transaction;

      repository.Transaction transaction = oldTransaction.copyWith(
        amount: num.parse(state.amount.value),
        cardId: state.card.value.id!,
        created: Timestamp.fromDate(state.created.value),
        note: state.note.value,
        purpose: state.purpose,
        title: state.title.value,
      );

      await _firebaseTransactionsRepository.updateTransaction(transaction: transaction, oldTransaction: oldTransaction);

      return state.copyWith(
        status: FormzStatus.submissionSuccess,
        transaction: transaction,
      );
    } catch (e) {
      throw e;
    }
  }
}
