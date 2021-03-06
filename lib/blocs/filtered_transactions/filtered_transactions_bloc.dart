import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';

import '../blocs.dart';

part 'filtered_transactions_event.dart';
part 'filtered_transactions_state.dart';

class FilteredTransactionsBloc extends Bloc<FilteredTransactionsEvent, FilteredTransactionsState> {
  FilteredTransactionsBloc({
    required TransactionsBloc transactionsBloc,
    required CarouselBloc carouselBloc,
  })   : _transactionsBloc = transactionsBloc,
        _carouselBloc = carouselBloc,
        super(FilteredTransactionsLoading()) {
    _transactionSubscription = _transactionsBloc.listen(_listenTransactionsBloc);
    _carouselSubscription = _carouselBloc.listen(_listenCarouselBloc);
  }

  final TransactionsBloc _transactionsBloc;
  final CarouselBloc _carouselBloc;
  late final StreamSubscription _transactionSubscription;
  late final StreamSubscription _carouselSubscription;

  @override
  Stream<FilteredTransactionsState> mapEventToState(
    FilteredTransactionsEvent event,
  ) async* {
    if (event is _FilterCardUpdated) {
      yield* _mapFilterCardUpdatedToState(event);
    } else if (event is _FilterTransactionsFail) {
      yield FilteredTransactionsFail();
    }
  }

  void _listenTransactionsBloc(TransactionsState state) {
    if (state is TransactionsLoadSuccess && _carouselBloc.state is CarouselLoadSuccess) {
      add(
        _FilterCardUpdated(
          (_carouselBloc.state as CarouselLoadSuccess).selectedCard,
        ),
      );
    } else if (state is TransactionsFailure) {
      add(_FilterTransactionsFail());
    }
  }

  void _listenCarouselBloc(CarouselState state) {
    if (state is CarouselLoadSuccess && _transactionsBloc.state is TransactionsLoadSuccess) {
      add(
        _FilterCardUpdated(state.selectedCard),
      );
    } else if (state is CarouselLoadFail) {
      add(_FilterTransactionsFail());
    }
  }

  @override
  Future<void> close() {
    _transactionSubscription.cancel();
    _carouselSubscription.cancel();
    return super.close();
  }

  Stream<FilteredTransactionsState> _mapFilterCardUpdatedToState(_FilterCardUpdated event) async* {
    if (_transactionsBloc.state is TransactionsLoadSuccess && _carouselBloc.state is CarouselLoadSuccess) {
      print('transactions length pure: ' + (_transactionsBloc.state as TransactionsLoadSuccess).transactions.length.toString());
      List<Transaction> transactions =
          (_transactionsBloc.state as TransactionsLoadSuccess).transactions.where((element) => element.cardId == event.card.id).toList();

      print('Transactions length  ' + transactions.length.toString());

      yield FilteredTransactionsSuccess(transactions);
    }
  }
}
