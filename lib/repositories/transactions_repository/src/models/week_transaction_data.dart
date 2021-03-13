import 'package:equatable/equatable.dart';

class WeekTransactionData extends Equatable {
  final int count;
  final int weekNumber;

  const WeekTransactionData({
    required this.count,
    required this.weekNumber,
  });

  @override
  List<Object?> get props => [count, weekNumber];
}
