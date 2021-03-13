import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/blocs/blocs.dart';

part 'transaction_period_chart_event.dart';
part 'transaction_period_chart_state.dart';

class TransactionsPeriodChartBloc extends Bloc<TransactionsPeriodChartEvent, TransactionsPeriodChartState> {
  TransactionsPeriodChartBloc({
    required StatsViewBloc statsViewBloc,
  })   : _statsViewBloc = statsViewBloc,
        super(TransactionChartLoading()) {
    _statsSubscripton = statsViewBloc.listen(_listenToStatsViewBloc);
  }

  final StatsViewBloc _statsViewBloc;
  late final StreamSubscription _statsSubscripton;

  @override
  Stream<TransactionsPeriodChartState> mapEventToState(
    TransactionsPeriodChartEvent event,
  ) async* {
    if (event is _StatsUpdated) {
      yield TransactionChartLoadSuccess(
        transactions: event.periodTransactions,
        view: View.week,
      );
    } else if (event is _TransactionChartFail) {
      yield TransactonChartFail();
    } else if (event is TransactionsChartChangeView) {
      if (_statsViewBloc.state is StatsViewLoadSuccess) {
        final stats = (_statsViewBloc.state as StatsViewLoadSuccess).transactionsStats;
        if (event.view == View.day) {
        } else if (event.view == View.week) {
          yield TransactionChartLoadSuccess(transactions: stats.transactionsByWeek, view: event.view);
        } else {
          //month
        }
      }
    }
  }

  void _listenToStatsViewBloc(StatsViewState statsState) {
    if (statsState is StatsViewLoadSuccess) {
      add(_StatsUpdated(statsState.transactionsStats.transactionsByWeek));
    } else if (statsState is StatsViewFailure) {
      add(_TransactionChartFail());
    }
  }

  @override
  Future<void> close() {
    _statsSubscripton.cancel();
    return super.close();
  }
}
