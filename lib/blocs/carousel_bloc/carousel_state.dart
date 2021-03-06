part of 'carousel_bloc.dart';

abstract class CarouselState extends Equatable {
  const CarouselState();

  @override
  List<Object> get props => [];
}

class CarouselLoading extends CarouselState {}

class CarouselLoadSuccess extends CarouselState {
  final List<CredictCard> cards;
  final CredictCard selectedCard;

  const CarouselLoadSuccess({
    required this.cards,
    required this.selectedCard,
  });

  @override
  List<Object> get props => [cards, selectedCard];

  CarouselLoadSuccess copyWith({
    List<CredictCard>? cards,
    CredictCard? selectedCard,
  }) {
    return CarouselLoadSuccess(
      cards: cards ?? this.cards,
      selectedCard: selectedCard ?? this.selectedCard,
    );
  }
}

class CarouselLoadFail extends CarouselState {}
