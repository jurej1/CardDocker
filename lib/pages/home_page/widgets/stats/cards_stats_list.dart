import 'package:flutter/material.dart';

import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';

class CardsStatsList extends StatelessWidget {
  final List<CredictCard> credictCards;
  final int _length;
  final String title;
  final BorderRadius _borderRadius = BorderRadius.circular(12);

  CardsStatsList({
    Key? key,
    required this.credictCards,
    required this.title,
  })   : _length = credictCards.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (credictCards.isEmpty) {
      return Container();
    } else {
      return Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        child: Container(
          height: _length < 3 ? ((_length + 1) * 40) + 16 + 10 : 200,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            borderRadius: _borderRadius,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: _length,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => _CardTile(card: credictCards[index]),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _CardTile extends StatelessWidget {
  final CredictCard card;
  final bool isNegative;
  final BorderRadius _circularBorderRadius = BorderRadius.circular(12);

  _CardTile({Key? key, required this.card})
      : isNegative = card.balance.isNegative,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: _circularBorderRadius,
      child: InkWell(
        borderRadius: _circularBorderRadius,
        onTap: () {
          //TODO ==> take the user to the card detail screen.
        },
        splashColor: Theme.of(context).primaryColor.withOpacity(0.7),
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: _circularBorderRadius,
                  color: card.color,
                  border: Border.all(
                    color: Colors.black45,
                    width: 1,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    card.note,
                    maxLines: 3,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: 40,
                  maxWidth: 100,
                ),
                height: 40,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '\$${card.balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isNegative ? FontWeight.bold : FontWeight.w600,
                      color: isNegative ? Colors.red : Colors.orange,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
