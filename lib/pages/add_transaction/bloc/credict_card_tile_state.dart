part of 'credict_card_tile_bloc.dart';

class CredictCardTileState extends Equatable {
  const CredictCardTileState({
    this.isExpanded = false,
  });

  final bool isExpanded;

  @override
  List<Object> get props => [isExpanded];

  CredictCardTileState copyWith({
    bool? isExpanded,
  }) {
    return CredictCardTileState(
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
