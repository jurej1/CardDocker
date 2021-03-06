part of 'carousel_bloc.dart';

abstract class CarouselEvent extends Equatable {
  const CarouselEvent();

  @override
  List<Object> get props => [];
}

class CarouselCardsUpdated extends CarouselEvent {
  final List<CredictCard> cards;

  const CarouselCardsUpdated(this.cards);

  @override
  List<Object> get props => [cards];
}

class CarouselSelectedCardUpdated extends CarouselEvent {
  final CredictCard card;

  const CarouselSelectedCardUpdated(this.card);

  @override
  List<Object> get props => [card];
}

class _CarouselCardsError extends CarouselEvent {}
