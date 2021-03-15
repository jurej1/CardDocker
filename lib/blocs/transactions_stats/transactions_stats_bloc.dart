import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/transactions_repository/src/transactions_repository.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';

import '../blocs.dart';

part 'transactions_stats_event.dart';
part 'transactions_stats_state.dart';

class TransactionsStatsBloc extends Bloc<TransactionsStatsEvent, TransactionsStatsState> {
  TransactionsStatsBloc({
    required TransactionsBloc transactionsBloc,
    required TransactionsRepository transactionsRepository,
  })   : _transactionsBloc = transactionsBloc,
        _transactionsRepository = transactionsRepository,
        super(TransactionStatsLoading()) {
    transactionsSubscription = _transactionsBloc.listen((tranState) {
      if (tranState is TransactionsLoadSuccess) {
        add(_TransactionsUpdated(tranState.transactions));
      } else if (tranState is TransactionsFailure) {
        add(_TransactionsError());
      }
    });
  }

  final TransactionsBloc _transactionsBloc;
  late final StreamSubscription transactionsSubscription;
  final TransactionsRepository _transactionsRepository;

  @override
  Stream<TransactionsStatsState> mapEventToState(
    TransactionsStatsEvent event,
  ) async* {
    if (event is _TransactionsUpdated) {
      try {
        BasicTransactionsStats stats = _transactionsRepository.getBasicTransactionsStats(event.transactions);
        yield TransactionsStatsLoadSuccess(basicStats: stats);
      } catch (e) {
        yield TransactionsStatsFailure();
      }
    } else if (event is _TransactionsError) {
      yield TransactionsStatsFailure();
    }
  }

  @override
  Future<void> close() {
    transactionsSubscription.cancel();
    return super.close();
  }
}
