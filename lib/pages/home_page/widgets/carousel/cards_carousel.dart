import 'package:card_docker/pages/pages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/carousel_bloc/carousel_bloc.dart';
import 'package:card_docker/pages/home_page/widgets/carousel/credict_card_widget.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

class CardsCarousel extends StatelessWidget {
  final List<CredictCard> cards;
  final int? selectedCard;

  const CardsCarousel({
    Key? key,
    required this.cards,
    required this.selectedCard,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: _CardsLoadedCarousel(
        cards: cards,
        selectedCard: selectedCard,
      ),
    );
  }
}

class _CardsLoadedCarousel extends StatelessWidget {
  final List<CredictCard> cards;
  final int? selectedCard;
  final cardBorderRadisu = BorderRadius.circular(12);

  _CardsLoadedCarousel({
    Key? key,
    required this.cards,
    this.selectedCard,
  }) : super(key: key);

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
        itemBuilder: (context, index, _) {
          final card = cards[index];

          return Material(
            color: card.color,
            shape: RoundedRectangleBorder(
              borderRadius: cardBorderRadisu,
            ),
            child: InkWell(
              borderRadius: cardBorderRadisu,
              onTap: () {
                Navigator.of(context).pushNamed(
                  CardDetailPage.routeName,
                  arguments: card,
                );
              },
              splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
              child: CredictCardWidget(
                card: card,
                isCarouselCard: true,
              ),
            ),
          );
        },
        options: CarouselOptions(
          initialPage: selectedCard!,
          scrollDirection: Axis.horizontal, //Experiment with vertical
          viewportFraction: 0.85,
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
