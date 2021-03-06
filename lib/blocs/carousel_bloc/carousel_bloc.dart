import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:equatable/equatable.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc({
    required CardsBloc cardsBloc,
  })   : _cardsBloc = cardsBloc,
        super(CarouselLoading()) {
    _cardsSubscription = _cardsBloc.listen(
      (state) {
        if (state is CardsLoadSuccess) {
          add(CarouselCardsUpdated(state.cards));
        } else if (state is CardsLoadFailure) {
          add(_CarouselCardsError());
        }
      },
    );
  }

  final CardsBloc _cardsBloc;
  late final StreamSubscription _cardsSubscription;

  @override
  Stream<CarouselState> mapEventToState(
    CarouselEvent event,
  ) async* {
    if (event is CarouselCardsUpdated) {
      yield CarouselLoadSuccess(
        cards: event.cards,
        selectedCard: event.cards.first,
      );
    } else if (event is _CarouselCardsError) {
      yield CarouselLoadFail();
    } else if (event is CarouselSelectedCardUpdated) {
      yield* _mapCarouselSelectedCardUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _cardsSubscription.cancel();
    return super.close();
  }

  Stream<CarouselState> _mapCarouselSelectedCardUpdatedToState(CarouselSelectedCardUpdated event) async* {
    if (state is CarouselLoadSuccess) {
      yield (state as CarouselLoadSuccess).copyWith(selectedCard: event.card);
    }
  }
}
