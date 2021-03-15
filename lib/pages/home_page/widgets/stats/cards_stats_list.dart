import 'package:card_docker/pages/home_page/widgets/carousel/carousel_card.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';

class CardsStatsList extends StatelessWidget {
  final List<CredictCard> credictCards;
  final int _length;
  final String title;

  const CardsStatsList({
    Key? key,
    required this.credictCards,
    required this.title,
  })   : _length = credictCards.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (credictCards.isEmpty)
      return Container();
    else
      return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title),
            Expanded(
              child: ListView.builder(
                itemCount: _length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      color: credictCards[index].color,
                    ),
                    title: Text('HEllo'),
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}
