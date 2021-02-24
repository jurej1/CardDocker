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

class CardsLoadFailure extends CardsState {}
