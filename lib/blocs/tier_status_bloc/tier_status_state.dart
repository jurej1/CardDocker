part of 'tier_status_bloc.dart';

abstract class TierStatusState extends Equatable {
  const TierStatusState();

  @override
  List<Object> get props => [];
}

class TierStatusLoading extends TierStatusState {}

class TierStatusLoadSuccess extends TierStatusState {
  final Tier currentTier;
  final int transactionsAmount;
  final Tier nextTier;
  final int amountTillNextTier;

  TierStatusLoadSuccess({
    required this.currentTier,
    required this.nextTier,
    required this.transactionsAmount,
  }) : amountTillNextTier = nextTier.amount - transactionsAmount;

  @override
  List<Object> get props => [currentTier, amountTillNextTier, transactionsAmount, nextTier];
}

class TierStatusFailure extends TierStatusState {}
