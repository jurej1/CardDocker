part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object> get props => [];
}

class CardsLoading extends CardsState {}

class CardsLoadSuccess extends CardsState {
  final List<CredictCard> cards;

  const CardsLoadSuccess({this.cards = const []});

  @override
  List<Object> get props => [cards];
}

class CardDeletedSuccess extends CardsState {
  final List<CredictCard> cards;

  const CardDeletedSuccess({this.cards = const []});

  @override
  List<Object> get props => [cards];
}

class CardsUpdateFailure extends CardsState {
  final List<CredictCard> cards;

  const CardsUpdateFailure({this.cards = const []});

  @override
  List<Object> get props => [cards];
}

class CardsLoadFailure extends CardsState {}
