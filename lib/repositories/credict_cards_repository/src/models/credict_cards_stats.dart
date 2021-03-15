import 'package:equatable/equatable.dart';

import 'card_purpose_stat.dart';
import 'models.dart';

class CredictCardsStats extends Equatable {
  final int numOfCards;
  final List<CardTypeStat> purposeStats;
  final double averageBalance;
  final double totalBalance;
  final double biggestBalance;
  final double smallestBalance;

  final List<CredictCard> cardsWithSmallAmount;
  final List<CredictCard> cardsWithNegativeBalance;

  const CredictCardsStats({
    required this.numOfCards,
    required this.purposeStats,
    required this.averageBalance,
    required this.biggestBalance,
    required this.smallestBalance,
    required this.totalBalance,
    required this.cardsWithNegativeBalance,
    required this.cardsWithSmallAmount,
  });

  static final empty = CredictCardsStats(
    averageBalance: 0,
    biggestBalance: 0,
    numOfCards: 0,
    purposeStats: const [],
    smallestBalance: 0,
    totalBalance: 0,
    cardsWithNegativeBalance: const [],
    cardsWithSmallAmount: const [],
  );

  @override
  List<Object?> get props => [
        numOfCards,
        purposeStats,
        averageBalance,
        totalBalance,
        biggestBalance,
        smallestBalance,
        cardsWithNegativeBalance,
        cardsWithSmallAmount
      ];

  CredictCardsStats copyWith({
    int? numOfCards,
    List<CardTypeStat>? purposeStats,
    double? averageBalance,
    double? totalBalance,
    double? biggestBalance,
    double? smallestBalance,
    List<CredictCard>? cardsWithSmallAmount,
    List<CredictCard>? cardsWithNegativeBalance,
  }) {
    return CredictCardsStats(
      numOfCards: numOfCards ?? this.numOfCards,
      purposeStats: purposeStats ?? this.purposeStats,
      averageBalance: averageBalance ?? this.averageBalance,
      totalBalance: totalBalance ?? this.totalBalance,
      biggestBalance: biggestBalance ?? this.biggestBalance,
      smallestBalance: smallestBalance ?? this.smallestBalance,
      cardsWithSmallAmount: cardsWithSmallAmount ?? this.cardsWithSmallAmount,
      cardsWithNegativeBalance: cardsWithNegativeBalance ?? this.cardsWithNegativeBalance,
    );
  }
}
