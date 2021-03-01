import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';

part 'add_transaction_form_event.dart';
part 'add_transaction_form_state.dart';

class AddTransactionFormBloc extends Bloc<AddTransactionFormEvent, AddTransactionFormState> {
  AddTransactionFormBloc({@required FirebaseTransactionsRepository firebaseTransactionsRepository, @required AuthBloc authBloc})
      : _firebaseTransactionsRepository = firebaseTransactionsRepository,
        _authBloc = authBloc,
        super(AddTransactionFormState.initial());

  final FirebaseTransactionsRepository _firebaseTransactionsRepository;
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
    final amount = Amount.dirty(event.value);

    return state.copyWith(
      amount: amount.valid ? amount : Amount.pure(event.value),
      status: Formz.validate([amount, state.title, state.cardId]),
    );
  }

  AddTransactionFormState _mapTransactionAmountUnfocusedToState() {
    final amount = Amount.dirty(state.amount.value);

    return state.copyWith(
      amount: amount,
      status: Formz.validate([amount, state.title, state.cardId]),
    );
  }

  AddTransactionFormState _mapTransactionCardIdChangedToState(TransactionCardIdChanged event) {
    final cardId = CardId.dirty(event.value);

    return state.copyWith(
      cardId: cardId,
      status: Formz.validate([state.amount, state.title, cardId]),
    );
  }

  AddTransactionFormState _mapTransactionTitleChangedToState(TransactionTitleChanged event) {
    final title = Title.dirty(event.value);

    return state.copyWith(
      status: Formz.validate([state.amount, title, state.cardId]),
      title: title.valid ? title : Title.pure(event.value),
    );
  }

  AddTransactionFormState _mapTransactionTitelUnfocusedToState() {
    final title = Title.dirty(state.title.value);

    return state.copyWith(
      title: title,
      status: Formz.validate([state.amount, title, state.cardId]),
    );
  }

  AddTransactionFormState _mapTransactionNoteChangedToState(TransactionNoteChanged event) {
    final note = Note.dirty(event.value);

    return state.copyWith(
      note: note,
      status: Formz.validate([state.amount, state.title, state.cardId]),
    );
  }

  Stream<AddTransactionFormState> _mapTransactionSubmitFormToState() async* {
    final amount = Amount.dirty(state.amount.value);
    final title = Title.dirty(state.title.value);
    final cardId = CardId.dirty(state.cardId.value);

    yield state.copyWith(
      amount: amount,
      cardId: cardId,
      title: title,
      status: Formz.validate([amount, title, cardId]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final user = (_authBloc.state as Authenticated).user;

        Transaction transaction = Transaction(
          amount: num.parse(state.amount.value),
          cardId: state.cardId.value,
          note: state.note.value ?? null,
          ownerId: user.id,
          title: state.title.value,
          purpose: state.purpose,
        );

        await _firebaseTransactionsRepository.addTransaction(transaction);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (error) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
