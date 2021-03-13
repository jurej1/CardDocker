part of 'transaction_data_bar_chart_bloc.dart';

abstract class TransactionDataBarChartEvent extends Equatable {
  const TransactionDataBarChartEvent();

  @override
  List<Object> get props => [];
}

class _StatsUpdated extends TransactionDataBarChartEvent {
  final List<PeriodTransactionData> stats;

  const _StatsUpdated({
    required this.stats,
  });
  @override
  List<Object> get props => [stats];
}

class _TransactionBarChartError extends TransactionDataBarChartEvent {}

class TransactionBarChartChangeView extends TransactionDataBarChartEvent {
  final View view;

  const TransactionBarChartChangeView(this.view);

  @override
  List<Object> get props => [view];
}
