part of 'transaction_period_chart_bloc.dart';

abstract class TransactionsPeriodChartState extends Equatable {
  const TransactionsPeriodChartState();

  @override
  List<Object> get props => [];
}

class TransactionChartLoading extends TransactionsPeriodChartState {}

enum View { day, week, month }

class TransactionChartLoadSuccess extends TransactionsPeriodChartState {
  final List<PeriodTransactions> transactions;
  final View view;

  const TransactionChartLoadSuccess({
    required this.transactions,
    required this.view,
  });

  @override
  List<Object> get props => [view, transactions];
}

class TransactonChartFail extends TransactionsPeriodChartState {}
