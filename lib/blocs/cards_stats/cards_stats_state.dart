part of 'cards_stats_bloc.dart';

abstract class CardsStatsState extends Equatable {
  const CardsStatsState();

  @override
  List<Object?> get props => [];
}

class CardsStatsLoading extends CardsStatsState {}

class CardsStatsLoadSuccess extends CardsStatsState {
  final CredictCardsStats? cardsStats;

  const CardsStatsLoadSuccess({this.cardsStats});

  @override
  List<Object?> get props => [cardsStats];
}

class CardsStatsFailure extends CardsStatsState {}
