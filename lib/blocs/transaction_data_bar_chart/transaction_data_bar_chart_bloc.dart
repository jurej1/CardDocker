import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';

import '../blocs.dart';

part 'transaction_data_bar_chart_event.dart';
part 'transaction_data_bar_chart_state.dart';

class TransactionDataBarChartBloc extends Bloc<TransactionDataBarChartEvent, TransactionDataBarChartState> {
  TransactionDataBarChartBloc({
    required StatsViewBloc statsViewBloc,
  })   : _statsViewBloc = statsViewBloc,
        super(TransactionDataBarChartLoading()) {
    _statsSubscripton = statsViewBloc.listen(_listenToStatsViewBloc);
  }

  final StatsViewBloc _statsViewBloc;
  late final StreamSubscription _statsSubscripton;

  @override
  Stream<TransactionDataBarChartState> mapEventToState(
    TransactionDataBarChartEvent event,
  ) async* {
    if (event is _StatsUpdated) {
      yield TransactionDataBarChartLoadSuccess(transactions: event.stats, view: View.week);
    } else if (event is _TransactionBarChartError) {
      yield TransctionDataBarChartFail();
    }
  }

  void _listenToStatsViewBloc(StatsViewState statsState) {
    if (statsState is StatsViewLoadSuccess) {
      add(_StatsUpdated(stats: statsState.transactionsStats.transactionsByWeek));
    } else if (statsState is StatsViewFailure) {
      add(_TransactionBarChartError());
    }
  }

  @override
  Future<void> close() {
    _statsSubscripton.cancel();
    return super.close();
  }
}
