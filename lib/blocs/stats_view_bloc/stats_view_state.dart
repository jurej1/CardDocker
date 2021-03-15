part of 'stats_view_bloc.dart';

abstract class StatsViewState extends Equatable {
  const StatsViewState();

  @override
  List<Object> get props => [];
}

class StatsViewLoading extends StatsViewState {}

class StatsViewLoadSuccess extends StatsViewState {
  final BasicTransactionsStats transactionsStats;
  final CredictCardsStats credictCardsStats;

  const StatsViewLoadSuccess({
    required this.transactionsStats,
    required this.credictCardsStats,
  });

  @override
  List<Object> get props => [transactionsStats, credictCardsStats];
}

class StatsViewFailure extends StatsViewState {}
