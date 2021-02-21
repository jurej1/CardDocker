import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({
    @required FirebaseCredictCardRepository firebaseCredictCardRepository,
    @required AuthBloc authBloc,
  })  : _firebaseCredictCardRepository = firebaseCredictCardRepository,
        _authBloc = authBloc,
        super(CardsLoading()) {
    _authSubsctiption = _authBloc.listen((state) {
      if (state is Authenticated) {
        add(LoadCards(state.user.id));
      }
    });
  }

  final FirebaseCredictCardRepository _firebaseCredictCardRepository;
  final AuthBloc _authBloc;
  StreamSubscription _cardsSubscription;
  StreamSubscription _authSubsctiption;

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
      this.add(CardsUpdated(cards));
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
    _authSubsctiption.cancel();
    _cardsSubscription.cancel();
    return super.close();
  }
}
