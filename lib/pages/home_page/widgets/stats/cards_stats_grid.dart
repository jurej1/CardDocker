import 'package:card_docker/pages/home_page/widgets/stats/grid_base.dart';
import 'package:card_docker/pages/home_page/widgets/stats/text_column.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_cards_stats.dart';
import 'package:flutter/material.dart';

class CardsStatsGrid extends StatelessWidget {
  final CredictCardsStats stats;

  const CardsStatsGrid({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridBase(
      children: [
        TextColumn(
          title: 'Amount of cards',
          content: stats.numOfCards.toString(),
        ),
        TextColumn(
          title: 'Average balance',
          content: '\$${stats.averageBalance.toStringAsFixed(2)}',
        ),
        TextColumn(
          title: 'Biggest balance',
          content: '\$${stats.biggestBalance.toStringAsFixed(2)}',
        ),
        TextColumn(
          title: 'Smallest balance',
          content: '\$${stats.smallestBalance.toStringAsFixed(2)}',
        ),
        TextColumn(
          title: 'Total balance',
          content: '\$${stats.totalBalance.toStringAsFixed(2)}',
        )
      ],
    );
  }
}
