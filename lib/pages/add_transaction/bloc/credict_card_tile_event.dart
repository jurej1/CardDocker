part of 'credict_card_tile_bloc.dart';

abstract class CredictCardTileEvent extends Equatable {
  const CredictCardTileEvent();

  @override
  List<Object> get props => [];
}

class CredictCardChangeView extends CredictCardTileEvent {}
