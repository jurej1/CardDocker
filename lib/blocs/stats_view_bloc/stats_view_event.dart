part of 'stats_view_bloc.dart';

abstract class StatsViewEvent extends Equatable {
  const StatsViewEvent();

  @override
  List<Object?> get props => [];
}

class _StatsViewError extends StatsViewEvent {}

class _StatsUpdated extends StatsViewEvent {
  final BasicTransactionsStats? basicTransactionsStats;
  final CredictCardsStats? credictCardsStats;

  const _StatsUpdated({
    this.basicTransactionsStats,
    this.credictCardsStats,
  });

  @override
  List<Object?> get props => [basicTransactionsStats, credictCardsStats];
}
