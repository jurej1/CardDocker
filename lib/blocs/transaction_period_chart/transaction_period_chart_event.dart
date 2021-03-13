part of 'transaction_period_chart_bloc.dart';

abstract class TransactionsPeriodChartEvent extends Equatable {
  const TransactionsPeriodChartEvent();

  @override
  List<Object> get props => [];
}

class _StatsUpdated extends TransactionsPeriodChartEvent {
  final List<PeriodTransactions> periodTransactions;

  const _StatsUpdated(this.periodTransactions);
  @override
  List<Object> get props => [periodTransactions];
}

class TransactionsChartChangeView extends TransactionsPeriodChartEvent {
  final View view;

  const TransactionsChartChangeView(this.view);
  @override
  List<Object> get props => [view];
}

class _TransactionChartFail extends TransactionsPeriodChartEvent {}
