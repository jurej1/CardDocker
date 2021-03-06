part of 'carousel_bloc.dart';

abstract class CarouselEvent extends Equatable {
  const CarouselEvent();

  @override
  List<Object?> get props => [];
}

class _CarouselUpdated extends CarouselEvent {
  final List<CredictCard> cards;
  final List<Transaction> transactions;

  const _CarouselUpdated({
    required this.transactions,
    required this.cards,
  });

  @override
  List<Object?> get props => [cards];
}

class CarouselSelectedCardUpdated extends CarouselEvent {
  final int index;

  const CarouselSelectedCardUpdated(this.index);

  @override
  List<Object> get props => [index];
}

class _CarouselError extends CarouselEvent {}
