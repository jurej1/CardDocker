import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:card_docker/repositories/transactions_repository/src/models/transaction_purpose_stat.dart';

class TransactionsPieChart extends StatelessWidget {
  final List<TransactionPurposeStat> purposeStats;
  late final List<TransactionPurposeStat> topFive;
  TransactionsPieChart({
    Key? key,
    required this.purposeStats,
  }) : super(key: key) {
    final List<TransactionPurposeStat> stats = purposeStats..sort((a, b) => b.count.compareTo(a.count));
    topFive = stats.length < 5 ? stats : stats.sublist(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    return PieChartBase(
      rightWidget: _Board(
        stats: topFive,
      ),
      sections: purposeStats.map((e) {
        final value = e.count.toDouble();
        final color = Colors.primaries.elementAt(math.Random().nextInt(Colors.primaries.length));
        return PieChartSectionData(
          color: color,
          value: value,
          radius: 35,
          title: value.toStringAsFixed(0),
          showTitle: true,
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList(growable: false),
    );
  }
}

class _Board extends StatelessWidget {
  final List<TransactionPurposeStat> stats;

  const _Board({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChartBoard(
      itemBuilder: (context, index) {
        return Text(
          "${stats[index].count}x - ${transactionPurposeToString(stats[index].purpose)}",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.fade,
        );
      },
      length: stats.length,
    );
  }
}
