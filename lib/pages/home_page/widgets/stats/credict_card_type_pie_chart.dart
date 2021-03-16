import 'dart:math' as math;

import 'package:card_docker/functions/credict_card_type_name.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/pages/home_page/widgets/stats/chart_board.dart';
import 'package:card_docker/pages/home_page/widgets/stats/pie_chart_base.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

class CredictCardTypePieChart extends StatelessWidget {
  final List<CardTypeStat> purposeStats;
  late List<CardTypeStat> topFive;

  CredictCardTypePieChart({
    Key? key,
    required this.purposeStats,
  }) : super(key: key) {
    List<CardTypeStat> stats = purposeStats..sort((a, b) => b.numOfCards.compareTo(a.numOfCards));
    topFive = stats.length < 5 ? stats : stats.sublist(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    return PieChartBase(
      rightWidget: _Board(
        list: topFive,
      ),
      sections: purposeStats.map((e) {
        final color = Colors.primaries.elementAt(math.Random().nextInt(Colors.primaries.length));

        return PieChartSectionData(
          color: color,
          titlePositionPercentageOffset: 0.6,
          radius: 35,
          showTitle: true,
          title: e.numOfCards.toString(),
          value: e.numOfCards.toDouble(),
        );
      }).toList(growable: false),
    );
  }
}

class _Board extends StatelessWidget {
  final List<CardTypeStat> list;

  const _Board({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChartBoard(
      length: list.length,
      itemBuilder: (context, index) {
        return Text(
          '${list[index].numOfCards}x - ${credictCardTypeName(list[index].type)}',
        );
      },
    );
  }
}
