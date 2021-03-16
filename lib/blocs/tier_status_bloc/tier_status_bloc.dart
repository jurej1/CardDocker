import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/constants/tiers.dart';
import 'package:card_docker/models/tier.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/blocs/blocs.dart';

part 'tier_status_event.dart';
part 'tier_status_state.dart';

class TierStatusBloc extends Bloc<TierStatusEvent, TierStatusState> {
  TierStatusBloc({
    required TransactionsBloc transactionsBloc,
  })   : _transactionsBloc = transactionsBloc,
        super(TierStatusLoading()) {
    _transactionsSubscription = _transactionsBloc.listen(_listenTransactionState);
  }

  final TransactionsBloc _transactionsBloc;
  late final StreamSubscription _transactionsSubscription;
  static final _tierValues = Tiers.values;

  @override
  Stream<TierStatusState> mapEventToState(
    TierStatusEvent event,
  ) async* {
    if (event is _TransactionsError) {
      yield TierStatusFailure();
    } else if (event is _TransactionsChanged) {
      yield* _mapTransactionsChangedToState(event);
    }
  }

  Stream<TierStatusState> _mapTransactionsChangedToState(_TransactionsChanged event) async* {
    try {
      final transactionsAmount = event.transactions.length;

      final currentTier = _tierValues.lastWhere((element) => element.amount < transactionsAmount);
      final nextTier = _tierValues.firstWhere((element) => element.amount > transactionsAmount);

      yield TierStatusLoadSuccess(
        currentTier: currentTier,
        nextTier: nextTier,
        transactionsAmount: transactionsAmount,
      );
    } catch (error) {
      yield TierStatusFailure();
    }
  }

  void _listenTransactionState(TransactionsState transactionsState) {
    if (transactionsState is TransactionsLoadSuccess) {
      add(_TransactionsChanged(transactions: transactionsState.transactions));
    } else if (transactionsState is TransactionsFailure) {
      add(_TransactionsError());
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    return super.close();
  }
}
