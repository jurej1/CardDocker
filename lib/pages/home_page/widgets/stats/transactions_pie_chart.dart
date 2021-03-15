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
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: _Chart(purposeStats: purposeStats),
          ),
          Expanded(
            child: _Board(
              stats: topFive,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final List<TransactionPurposeStat> purposeStats;

  const _Chart({Key? key, required this.purposeStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 150,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 20,
          sections: purposeStats.map((e) {
            final value = e.count.toDouble();
            final color = Colors.primaries.elementAt(math.Random().nextInt(Colors.primaries.length));
            return PieChartSectionData(
              color: color,
              value: value,
              radius: 30,
              title: value.toStringAsFixed(0),
              showTitle: true,
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _Board extends StatelessWidget {
  final List<TransactionPurposeStat> stats;

  const _Board({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Text(
                "${stats[index].count}x - ${transactionPurposeToString(stats[index].purpose)}",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.fade,
              );
            },
            itemCount: stats.length,
          ),
        ],
      ),
    );
  }

  String _title() {
    switch (stats.length) {
      case 1:
        return 'Top one';
      case 2:
        return 'Top two';
      case 3:
        return 'Top three';
      case 4:
        return 'Top four';
      default:
        return 'Top five';
    }
  }
}
