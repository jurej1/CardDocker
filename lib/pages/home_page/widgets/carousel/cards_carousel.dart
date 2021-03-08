import 'package:card_docker/blocs/carousel_bloc/carousel_bloc.dart';
import 'package:card_docker/pages/home_page/widgets/carousel/carousel_card.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsCarousel extends StatelessWidget {
  final List<CredictCard> cards;

  const CardsCarousel({Key? key, required this.cards}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: _CardsLoadedCarousel(cards: cards),
    );
  }
}

class _CardsLoadedCarousel extends StatelessWidget {
  final List<CredictCard> cards;

  const _CardsLoadedCarousel({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Center(
        child: Text(
          'Click on the top right button to start adding credict cards.',
        ),
      );
    } else {
      return CarouselSlider.builder(
        itemCount: cards.length,
        itemBuilder: (context, index, _) => CarouselCard(card: cards[index]),
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          enlargeCenterPage: true,
          aspectRatio: 16 / 7,
          enableInfiniteScroll: false,
          onPageChanged: (index, carouselOptions) => BlocProvider.of<CarouselBloc>(context).add(CarouselSelectedCardUpdated(index)),
        ),
      );
    }
  }
}
