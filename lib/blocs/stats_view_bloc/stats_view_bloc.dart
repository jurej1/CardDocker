import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/basic_transactions_stats.dart';
import 'package:equatable/equatable.dart';

part 'stats_view_event.dart';
part 'stats_view_state.dart';

class StatsViewBloc extends Bloc<StatsViewEvent, StatsViewState> {
  StatsViewBloc({
    required TransactionsStatsBloc transactionsStatsBloc,
    required CardsStatsBloc cardsStatsBloc,
  })   : _transactionsStatsBloc = transactionsStatsBloc,
        _cardsStatsBloc = cardsStatsBloc,
        super(StatsViewLoading()) {
    _cardsSubscription = _cardsStatsBloc.listen(_listenCardsStatsBloc);
    _transactionsSubscription = _transactionsStatsBloc.listen(_listenTransactionsStatsBloc);
  }

  final TransactionsStatsBloc _transactionsStatsBloc;
  final CardsStatsBloc _cardsStatsBloc;
  late final StreamSubscription _transactionsSubscription;
  late final StreamSubscription _cardsSubscription;

  @override
  Stream<StatsViewState> mapEventToState(
    StatsViewEvent event,
  ) async* {
    if (event is _StatsUpdated) {
      yield* _mapStatsUpdatedToState(event);
    } else if (event is _StatsViewError) {
      yield StatsViewFailure();
    }
  }

  void _listenCardsStatsBloc(CardsStatsState cardsState) {
    if (cardsState is CardsStatsLoadSuccess && _transactionsStatsBloc.state is TransactionsStatsLoadSuccess) {
      add(
        _StatsUpdated(
          credictCardsStats: cardsState.cardsStats,
          basicTransactionsStats: (_transactionsStatsBloc.state as TransactionsStatsLoadSuccess).basicStats,
        ),
      );
    } else if (cardsState is CardsStatsFailure) {
      add(_StatsViewError());
    }
  }

  void _listenTransactionsStatsBloc(TransactionsStatsState transactionsState) {
    if (transactionsState is TransactionsStatsLoadSuccess && _cardsStatsBloc.state is CardsStatsLoadSuccess) {
      add(_StatsUpdated(
        basicTransactionsStats: transactionsState.basicStats,
        credictCardsStats: (_cardsStatsBloc.state as CardsStatsLoadSuccess).cardsStats,
      ));
    } else if (transactionsState is TransactionsStatsFailure) {
      add(_StatsViewError());
    }
  }

  @override
  Future<void> close() {
    _transactionsSubscription.cancel();
    _cardsSubscription.cancel();
    return super.close();
  }

  Stream<StatsViewState> _mapStatsUpdatedToState(_StatsUpdated event) async* {
    if (_transactionsStatsBloc.state is TransactionsStatsLoadSuccess && _cardsStatsBloc.state is CardsStatsLoadSuccess) {
      if (event.basicTransactionsStats != null && event.basicTransactionsStats != null) {
        yield StatsViewLoadSuccess(
          transactionsStats: event.basicTransactionsStats!,
          credictCardsStats: event.credictCardsStats!,
        );
      } else {
        yield StatsViewTransactionsNotAvailable();
      }
    }
  }
}
