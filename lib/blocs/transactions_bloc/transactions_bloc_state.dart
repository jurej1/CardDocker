part of 'transactions_bloc_bloc.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoadSuccess extends TransactionsState {
  final List<Transaction> transactions;

  const TransactionsLoadSuccess({this.transactions = const []});

  @override
  List<Object> get props => [transactions];
}

class TransactionsFailure extends TransactionsState {}
