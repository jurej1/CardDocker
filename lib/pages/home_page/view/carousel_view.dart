import 'package:card_docker/blocs/carousel_bloc/carousel_bloc.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          ActionSelector(),
        ],
      ),
      body: BlocBuilder<CarouselBloc, CarouselState>(
        builder: (context, state) {
          if (state is CarouselLoadSuccess) {
            return _CarouselList(state: state);
          } else if (state is CarouselLoadFail) {
            return Center(
              child: Text('Somethnig went wrong'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _CarouselList extends StatelessWidget {
  final CarouselLoadSuccess state;

  const _CarouselList({Key? key, required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      height: height,
      width: width,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          CardsCarousel(cards: state.cards!),
          Divider(
            color: Colors.black45,
          ),
          TransactionsTitle(),
          CardTransactionsList(
            transactions: state.currentCardTransactions!,
          ),
        ],
      ),
    );
  }
}
