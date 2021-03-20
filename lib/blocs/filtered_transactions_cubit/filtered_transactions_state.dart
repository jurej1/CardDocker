part of 'filtered_transactions_cubit.dart';

abstract class FilteredTransactionsState extends Equatable {
  const FilteredTransactionsState();

  @override
  List<Object> get props => [];
}

class FilteredTransactionsLoadSuccess extends FilteredTransactionsState {
  final List<Transaction> transactions;

  const FilteredTransactionsLoadSuccess({
    this.transactions = const [],
  });
  @override
  List<Object> get props => [transactions];
}

class FilteredTransactionsFailure extends FilteredTransactionsState {}
