import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';

class TransactionPurposeStat extends Equatable {
  final TransactionPurpose purpose;
  final int count;

  const TransactionPurposeStat({
    required this.purpose,
    required this.count,
  });

  @override
  List<Object?> get props => [purpose, count];

  TransactionPurposeStat copyWith({
    TransactionPurpose? purpose,
    int? count,
  }) {
    return TransactionPurposeStat(
      purpose: purpose ?? this.purpose,
      count: count ?? this.count,
    );
  }
}
