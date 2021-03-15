part of 'transactions_stats_bloc.dart';

abstract class TransactionsStatsState extends Equatable {
  const TransactionsStatsState();

  @override
  List<Object> get props => [];
}

class TransactionStatsLoading extends TransactionsStatsState {}

class TransactionsStatsLoadSuccess extends TransactionsStatsState {
  final BasicTransactionsStats basicStats;

  const TransactionsStatsLoadSuccess({required this.basicStats});

  @override
  List<Object> get props => [basicStats];
}

class TranasctionsStatsFailure extends TransactionsStatsState {}
