part of 'transaction_data_bar_chart_bloc.dart';

abstract class TransactionDataBarChartState extends Equatable {
  const TransactionDataBarChartState();

  @override
  List<Object> get props => [];
}

class TransactionDataBarChartLoading extends TransactionDataBarChartState {}

enum View { day, week, month }

class TransactionDataBarChartLoadSuccess extends TransactionDataBarChartState {
  final List<PeriodTransactionData> transactions;
  final View view;

  const TransactionDataBarChartLoadSuccess({
    required this.transactions,
    required this.view,
  });

  @override
  List<Object> get props => [transactions];
}

class TransctionDataBarChartFail extends TransactionDataBarChartState {}
