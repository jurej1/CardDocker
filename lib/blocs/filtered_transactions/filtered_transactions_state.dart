part of 'filtered_transactions_bloc.dart';

abstract class FilteredTransactionsState extends Equatable {
  const FilteredTransactionsState();

  @override
  List<Object> get props => [];
}

class FilteredTransactionsLoading extends FilteredTransactionsState {}

class FilteredTransactionsSuccess extends FilteredTransactionsState {
  final List<Transaction> transactions;

  const FilteredTransactionsSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class FilteredTransactionsFail extends FilteredTransactionsState {}
