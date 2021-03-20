import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:equatable/equatable.dart';

part 'detail_card_state.dart';

class DetailCardCubit extends Cubit<DetailCardState> {
  DetailCardCubit({
    required CredictCard card,
    required CardsBloc cardsBloc,
  })   : _cardsBloc = cardsBloc,
        super(DetailCardState(card: card)) {
    _cardsSubscription = _cardsBloc.listen((cardsState) {
      if (cardsState is CardsLoadSuccess) {
        final updatedCard = cardsState.cards.firstWhere((element) => element.id == card.id);
        emit(DetailCardState(card: updatedCard));
      }
    });
  }

  final CardsBloc _cardsBloc;
  late final StreamSubscription _cardsSubscription;

  @override
  Future<void> close() {
    _cardsSubscription.cancel();
    return super.close();
  }
}
