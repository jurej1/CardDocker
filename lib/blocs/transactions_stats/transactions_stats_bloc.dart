import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';

import '../blocs.dart';

part 'transactions_stats_event.dart';
part 'transactions_stats_state.dart';

class TransactionsStatsBloc extends Bloc<TransactionsStatsEvent, TransactionsStatsState> {
  TransactionsStatsBloc({
    required TransactionsBloc transactionsBloc,
  })   : _transactionsBloc = transactionsBloc,
        super(TransactionStatsLoading()) {
    transactionsSubscription = _transactionsBloc.listen((tranState) {
      if (tranState is TransactionsLoadSuccess) {
        add(_TransactionsUpdated(tranState.transactions));
      }
    });
  }

  final TransactionsBloc _transactionsBloc;
  late final StreamSubscription transactionsSubscription;

  @override
  Stream<TransactionsStatsState> mapEventToState(
    TransactionsStatsEvent event,
  ) async* {
    if (event is _TransactionsUpdated) {}
  }

  @override
  Future<void> close() {
    transactionsSubscription.cancel();
    return super.close();
  }
}
