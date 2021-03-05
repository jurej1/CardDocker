import 'package:flutter/material.dart';

import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

class CardsList extends StatelessWidget {
  final List<CredictCard> cards;

  const CardsList({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Center(
        child: Text('You do not have any cards yet start by adding one.'),
      );
    } else {
      return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Container(
            child: Text('Card: $index'),
          );
        },
      );
    }
  }
}
