part of 'cards_stats_bloc.dart';

abstract class CardsStatsEvent extends Equatable {
  const CardsStatsEvent();

  @override
  List<Object> get props => [];
}

class _CardsUpdated extends CardsStatsEvent {
  final List<CredictCard> cards;

  const _CardsUpdated(this.cards);

  @override
  List<Object> get props => [cards];
}

class _CardsError extends CardsStatsEvent {}
