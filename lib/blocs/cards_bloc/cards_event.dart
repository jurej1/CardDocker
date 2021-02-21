part of 'cards_bloc.dart';

abstract class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class LoadCards extends CardsEvent {
  final String userId;

  const LoadCards(this.userId);

  @override
  List<Object> get props => [userId];
}

class CardsUpdated extends CardsEvent {
  final List<CredictCard> cards;

  const CardsUpdated(this.cards);

  @override
  List<Object> get props => [cards];
}

class CardDelete extends CardsEvent {
  final CredictCard card;

  const CardDelete(this.card);

  @override
  List<Object> get props => [card];
}
