import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc({
    required CardsBloc cardsBloc,
    required TransactionsBloc transactionsBloc,
  })   : _cardsBloc = cardsBloc,
        _transactionsBloc = transactionsBloc,
        super(CarouselLoading()) {
    _cardsSubscription = _cardsBloc.listen(_listenCardsBloc);
    _transactionsSubscription = _transactionsBloc.listen(_listenTransactionsBloc);
  }

  final CardsBloc _cardsBloc;
  late final StreamSubscription _cardsSubscription;
  final TransactionsBloc _transactionsBloc;
  late final StreamSubscription _transactionsSubscription;

  @override
  Stream<CarouselState> mapEventToState(
    CarouselEvent event,
  ) async* {
    if (event is _CarouselUpdated) {
      yield* _mapCarouselUpdatedToState(event);
    } else if (event is _CarouselError) {
      yield CarouselLoadFail();
    } else if (event is CarouselSelectedCardUpdated) {
      yield* _mapCarouselSelectedCardUpdatedToState(event);
    }
  }

  Stream<CarouselState> _mapCarouselUpdatedToState(_CarouselUpdated event) async* {
    if (_transactionsBloc.state is TransactionsLoadSuccess && _cardsBloc.state is CardsLoadSuccess) {
      final cards = event.cards;
      final currentCard = cards.first;
      final cardTransactions =
          (_transactionsBloc.state as TransactionsLoadSuccess).transactions.where((element) => element.cardId == currentCard.id).toList();

      yield CarouselLoadSuccess(
        cards: cards,
        currentCardTransactions: cardTransactions,
        index: 0,
        selectedCard: currentCard,
      );
    }
  }

  Stream<CarouselState> _mapCarouselSelectedCardUpdatedToState(CarouselSelectedCardUpdated event) async* {
    if (_transactionsBloc.state is TransactionsLoadSuccess && _cardsBloc.state is CardsLoadSuccess && this.state is CarouselLoadSuccess) {
      final currentState = this.state as CarouselLoadSuccess;
      final newCard = currentState.cards![event.index];
      final transactionsState = _transactionsBloc.state as TransactionsLoadSuccess;
      final transactions = transactionsState.transactions.where((element) => element.cardId == newCard.id).toList();

      yield CarouselLoadSuccess(
        cards: currentState.cards,
        currentCardTransactions: transactions,
        index: event.index,
        selectedCard: newCard,
      );
    }
  }

  void _listenCardsBloc(CardsState cardsState) {
    if (cardsState is CardsLoadSuccess && _transactionsBloc.state is TransactionsLoadSuccess) {
      add(
        _CarouselUpdated(
          transactions: (_transactionsBloc.state as TransactionsLoadSuccess).transactions,
          cards: cardsState.cards,
        ),
      );
    } else if (state is CardsLoadFailure) {
      add(_CarouselError());
    }
  }

  void _listenTransactionsBloc(TransactionsState transactionsState) {
    if (transactionsState is TransactionsLoadSuccess && _cardsBloc.state is CardsLoadSuccess) {
      add(
        _CarouselUpdated(
          transactions: transactionsState.transactions,
          cards: (_cardsBloc.state as CardsLoadSuccess).cards,
        ),
      );
    } else if (transactionsState is TransactionsFailure) {
      add(_CarouselError());
    }
  }

  @override
  Future<void> close() {
    _cardsSubscription.cancel();
    _transactionsSubscription.cancel();
    return super.close();
  }
}
