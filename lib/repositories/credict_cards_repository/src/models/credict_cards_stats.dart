import 'package:equatable/equatable.dart';

import 'card_purpose_stat.dart';

class CredictCardsStats extends Equatable {
  final int numOfCards;
  final List<CardTypeStat> purposeStats;

  const CredictCardsStats({
    required this.numOfCards,
    required this.purposeStats,
  });

  @override
  List<Object?> get props => [numOfCards, purposeStats];
}
