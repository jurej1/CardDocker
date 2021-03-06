part of 'filtered_transactions_bloc.dart';

abstract class FilteredTransactionsEvent extends Equatable {
  const FilteredTransactionsEvent();

  @override
  List<Object> get props => [];
}

class _FilterCardUpdated extends FilteredTransactionsEvent {
  final CredictCard card;

  const _FilterCardUpdated(this.card);

  @override
  List<Object> get props => [card];
}

class _FilterTransactionsFail extends FilteredTransactionsEvent {}
