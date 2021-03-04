import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';

part 'add_transaction_form_event.dart';
part 'add_transaction_form_state.dart';

class AddTransactionFormBloc extends Bloc<AddTransactionFormEvent, AddTransactionFormState> {
  AddTransactionFormBloc({required FirebaseTransactionsRepository firebaseTransactionsRepository, required AuthBloc authBloc})
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
    }
  }

  AddTransactionFormState _mapTransactionAmountChangedToState(TransactionAmountChanged event) {
    final amount = Amount.dirty(event.value);
    print('Amount Changed' + amount.value);

    return state.copyWith(
      amount: amount.valid ? amount : Amount.pure(event.value),
      status: Formz.validate([amount, state.title, state.card]),
    );
  }

  AddTransactionFormState _mapTransactionAmountUnfocusedToState() {
    final amount = Amount.dirty(state.amount.value);
    print('Amount Unfocused' + amount.value);
    return state.copyWith(
      amount: amount,
      status: Formz.validate([amount, state.title, state.card]),
    );
  }

  AddTransactionFormState _mapTransactionCardIdChangedToState(TransactionCardChanged event) {
    final card = Card.dirty(event.card);

    return state.copyWith(
      card: card,
      status: Formz.validate([state.amount, state.title, card]),
    );
  }

  AddTransactionFormState _mapTransactionTitleChangedToState(TransactionTitleChanged event) {
    final title = Title.dirty(event.value);

    return state.copyWith(
      status: Formz.validate([state.amount, title, state.card]),
      title: title.valid ? title : Title.pure(event.value),
    );
  }

  AddTransactionFormState _mapTransactionTitelUnfocusedToState() {
    final title = Title.dirty(state.title.value);

    return state.copyWith(
      title: title,
      status: Formz.validate([state.amount, title, state.card]),
    );
  }

  AddTransactionFormState _mapTransactionNoteChangedToState(TransactionNoteChanged event) {
    final note = Note.dirty(event.value);

    return state.copyWith(
      note: note,
      status: Formz.validate([state.amount, state.title, state.card]),
    );
  }

  Stream<AddTransactionFormState> _mapTransactionSubmitFormToState() async* {
    final amount = Amount.dirty(state.amount.value);
    final title = Title.dirty(state.title.value);
    final card = Card.dirty(state.card.value);

    yield state.copyWith(
      amount: amount,
      card: card,
      title: title,
      status: Formz.validate([amount, title, card]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final user = (_authBloc.state as Authenticated).user;

        Transaction transaction = Transaction(
          amount: num.parse(state.amount.value),
          cardId: state.card.value.id!,
          note: state.note.value,
          ownerId: user.id!,
          title: state.title.value,
          purpose: state.purpose!,
        );

        await _firebaseTransactionsRepository.addTransaction(transaction);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } catch (error) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
