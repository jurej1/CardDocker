import 'package:card_docker/blocs/carousel_bloc/carousel_bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.green,
      child: BlocBuilder<CarouselBloc, CarouselState>(
        builder: (context, state) {
          if (state is CarouselLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CarouselLoadSuccess) {
            return _CardsLoadedCarousel(cards: state.cards!);
          } else if (state is CarouselLoadFail) {
            return _CardsFailure();
          }
          return Container();
        },
      ),
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
        itemBuilder: (context, index, _) {
          return Container(
            color: Colors.red,
            child: Center(
              child: Text(cards[index].note),
            ),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          aspectRatio: 16 / 7,
          enableInfiniteScroll: false,
          onPageChanged: (index, carouselOptions) => BlocProvider.of<CarouselBloc>(context).add(CarouselSelectedCardUpdated(index)),
        ),
      );
    }
  }
}

class _CardsFailure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Sorry but there was an error',
      ),
    );
  }
}
