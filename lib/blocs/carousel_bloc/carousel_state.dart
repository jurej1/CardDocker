part of 'carousel_bloc.dart';

abstract class CarouselState extends Equatable {
  const CarouselState();

  @override
  List<Object?> get props => [];
}

class CarouselLoading extends CarouselState {}

class CarouselLoadSuccess extends CarouselState {
  final List<CredictCard>? cards;
  final List<Transaction>? currentCardTransactions;
  final CredictCard? selectedCard;
  final int? index;

  const CarouselLoadSuccess({
    this.cards = const [],
    this.currentCardTransactions = const [],
    this.selectedCard,
    this.index,
  });

  CarouselLoadSuccess copyWith({
    List<CredictCard>? cards,
    List<Transaction>? currentCardTransactions,
    CredictCard? selectedCard,
    int? index,
  }) {
    return CarouselLoadSuccess(
      cards: cards ?? this.cards,
      currentCardTransactions: currentCardTransactions ?? this.currentCardTransactions,
      selectedCard: selectedCard ?? this.selectedCard,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [cards, currentCardTransactions, selectedCard, index];
}

class CarouselLoadFail extends CarouselState {}
