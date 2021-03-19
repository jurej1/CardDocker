import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';

part 'cards_stats_event.dart';
part 'cards_stats_state.dart';

class CardsStatsBloc extends Bloc<CardsStatsEvent, CardsStatsState> {
  CardsStatsBloc({
    required FirebaseCredictCardRepository firebaseCredictCardRepository,
    required CardsBloc cardsBloc,
  })   : _cardsBloc = cardsBloc,
        _firebaseCredictCardRepository = firebaseCredictCardRepository,
        super(CardsStatsLoading()) {
    _cardsSubscription = _cardsBloc.listen((cardState) {
      if (cardState is CardsLoadSuccess) {
        add(_CardsUpdated(cardState.cards));
      } else if (state is CardsLoadFailure) {
        add(_CardsError());
      }
    });
  }

  final FirebaseCredictCardRepository _firebaseCredictCardRepository;
  final CardsBloc _cardsBloc;
  late final StreamSubscription _cardsSubscription;

  @override
  Stream<CardsStatsState> mapEventToState(
    CardsStatsEvent event,
  ) async* {
    if (event is _CardsUpdated) {
      if (event.cards.isNotEmpty) {
        CredictCardsStats stats = _firebaseCredictCardRepository.getCredictCardStats(event.cards);
        yield CardsStatsLoadSuccess(cardsStats: stats);
      } else {
        yield CardsStatsLoadSuccess();
      }
    } else if (event is _CardsError) {
      yield CardsStatsFailure();
    }
  }

  @override
  Future<void> close() {
    _cardsSubscription.cancel();
    return super.close();
  }
}
