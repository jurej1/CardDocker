part of 'add_transaction_form_bloc.dart';

abstract class AddTransactionFormEvent extends Equatable {
  const AddTransactionFormEvent();

  @override
  List<Object> get props => [];
}

class TransactionPurposeChanged extends AddTransactionFormEvent {
  final repository.TransactionPurpose purpose;

  const TransactionPurposeChanged(this.purpose);

  @override
  List<Object> get props => [purpose];
}

class TransactionAmountChanged extends AddTransactionFormEvent {
  final String value;

  const TransactionAmountChanged(this.value);

  @override
  List<Object> get props => [value];
}

class TransactionAmountUnfocused extends AddTransactionFormEvent {}

class TransactionCardChanged extends AddTransactionFormEvent {
  final CredictCard card;

  const TransactionCardChanged(this.card);

  @override
  List<Object> get props => [card];
}

class TransactionTitleChanged extends AddTransactionFormEvent {
  final String value;

  const TransactionTitleChanged(this.value);

  @override
  List<Object> get props => [value];
}

class TransactionTitleUnfocused extends AddTransactionFormEvent {}

class TransactionNoteChanged extends AddTransactionFormEvent {
  final String value;

  const TransactionNoteChanged(this.value);

  @override
  List<Object> get props => [value];
}

class TransactionCreatedChanged extends AddTransactionFormEvent {
  final DateTime value;

  const TransactionCreatedChanged(this.value);

  @override
  List<Object> get props => [value];
}

class TransactionSubmitForm extends AddTransactionFormEvent {}
