part of 'tier_status_bloc.dart';

abstract class TierStatusEvent extends Equatable {
  const TierStatusEvent();

  @override
  List<Object> get props => [];
}

class _TransactionsChanged extends TierStatusEvent {
  final List<Transaction> transactions;

  const _TransactionsChanged({
    required this.transactions,
  });

  @override
  List<Object> get props => [transactions];
}

class _TransactionsError extends TierStatusEvent {}
