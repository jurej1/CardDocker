import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

class CardTypeStat extends Equatable {
  final CredictCardType type;
  final int numOfCards;

  const CardTypeStat({
    required this.type,
    required this.numOfCards,
  });

  @override
  List<Object> get props => [type, numOfCards];
}
