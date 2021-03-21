part of 'detail_card_cubit.dart';

class DetailCardState extends Equatable {
  const DetailCardState({
    required this.card,
  });

  final CredictCard card;

  @override
  List<Object> get props => [card];
}
