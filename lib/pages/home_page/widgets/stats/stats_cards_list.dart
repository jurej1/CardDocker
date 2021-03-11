import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatsCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TransactionsStatsCard(),
            const SizedBox(
              height: 15,
            ),
            CardsStatsCard(),
          ],
        ),
      ),
    );
  }
}
