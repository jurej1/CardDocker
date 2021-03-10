part of 'transactions_stats_bloc.dart';

abstract class TransactionsStatsEvent extends Equatable {
  const TransactionsStatsEvent();

  @override
  List<Object> get props => [];
}

class _TransactionsUpdated extends TransactionsStatsEvent {
  final List<Transaction> transactions;

  const _TransactionsUpdated(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class _TransactionsError extends TransactionsStatsEvent {}
