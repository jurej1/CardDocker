import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credict_card_tile_event.dart';
part 'credict_card_tile_state.dart';

class CredictCardTileBloc extends Bloc<CredictCardTileEvent, CredictCardTileState> {
  CredictCardTileBloc() : super(CredictCardTileState());

  @override
  Stream<CredictCardTileState> mapEventToState(
    CredictCardTileEvent event,
  ) async* {
    if (event is CredictCardChangeView) {
      yield state.copyWith(isExpanded: !state.isExpanded);
    }
  }
}
