import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart' as jiffy;

class PeriodTransactionData extends Equatable {
  final int count;
  final DateTime startDate;

  const PeriodTransactionData({
    required this.count,
    required this.startDate,
  });

  @override
  List<Object?> get props => [count, startDate];

  int weekNumber() => jiffy.Jiffy(startDate).week;
}
