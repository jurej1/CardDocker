import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/credict_cards_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({
    required CredictCardsRepository firebaseCredictCardRepository,
  })   : _firebaseCredictCardRepository = firebaseCredictCardRepository,
        super(CardsLoading());

  late final CredictCardsRepository _firebaseCredictCardRepository;
  late final StreamSubscription _cardsSubscription;

  @override
  Stream<CardsState> mapEventToState(
    CardsEvent event,
  ) async* {
    if (event is LoadCards) {
      _mapLoadCardsToState(event);
    } else if (event is CardsUpdated) {
      yield _mapCardsUpdatedToState(event);
    } else if (event is CardDelete) {
      _mapCardDeleteToState(event);
    }
  }

  void _mapLoadCardsToState(LoadCards event) {
    _cardsSubscription = _firebaseCredictCardRepository.cards(event.userId).listen((cards) {
      add(CardsUpdated(cards));
    });
  }

  CardsState _mapCardsUpdatedToState(CardsUpdated event) {
    return CardsLoadSuccess(cards: event.cards);
  }

  void _mapCardDeleteToState(CardDelete event) {
    _firebaseCredictCardRepository.deleteCredictCard(event.card);
  }

  @override
  Future<void> close() {
    _cardsSubscription.cancel();
    return super.close();
  }
}
