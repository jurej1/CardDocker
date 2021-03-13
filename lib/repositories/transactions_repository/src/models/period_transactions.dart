import 'package:equatable/equatable.dart';

class PeriodTransactions extends Equatable {
  final DateTime period;
  final int count;

  const PeriodTransactions({required this.period, required this.count});

  @override
  List<Object?> get props => [period, count];
}
