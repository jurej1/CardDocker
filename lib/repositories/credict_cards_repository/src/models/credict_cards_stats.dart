import 'package:equatable/equatable.dart';

import 'card_purpose_stat.dart';

class CredictCardsStats extends Equatable {
  final int numOfCards;
  final List<CardTypeStat> purposeStats;
  final double averageBalance;
  final double totalBalance;
  final double biggestBalance;
  final double smallestBalance;

  const CredictCardsStats({
    required this.numOfCards,
    required this.purposeStats,
    required this.averageBalance,
    required this.biggestBalance,
    required this.smallestBalance,
    required this.totalBalance,
  });

  static final empty = CredictCardsStats(
    averageBalance: 0,
    biggestBalance: 0,
    numOfCards: 0,
    purposeStats: const [],
    smallestBalance: 0,
    totalBalance: 0,
  );

  @override
  List<Object?> get props => [
        numOfCards,
        purposeStats,
        averageBalance,
        totalBalance,
        biggestBalance,
        smallestBalance,
      ];

  CredictCardsStats copyWith({
    int? numOfCards,
    List<CardTypeStat>? purposeStats,
    double? averageBalance,
    double? totalBalance,
    double? biggestBalance,
    double? smallestBalance,
  }) {
    return CredictCardsStats(
      numOfCards: numOfCards ?? this.numOfCards,
      purposeStats: purposeStats ?? this.purposeStats,
      averageBalance: averageBalance ?? this.averageBalance,
      totalBalance: totalBalance ?? this.totalBalance,
      biggestBalance: biggestBalance ?? this.biggestBalance,
      smallestBalance: smallestBalance ?? this.smallestBalance,
    );
  }
}
