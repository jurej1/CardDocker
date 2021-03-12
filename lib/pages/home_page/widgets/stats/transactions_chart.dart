import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/repositories/transactions_repository/src/models/transaction_purpose_stat.dart';

class TransactionsChart extends StatelessWidget {
  final List<TransactionPurposeStat> purposStats;
  late final int totalValue;
  TransactionsChart({
    Key? key,
    required this.purposStats,
  }) : super(key: key) {
    totalValue = purposStats.fold(0, (previousValue, element) => previousValue + element.count);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: purposStats.map((e) {
            final value = e.count;
            print('Item value $value');
            return PieChartSectionData(
              title: transactionPurposeToString(e.purpose),
              titlePositionPercentageOffset: 1.0,
              color: Colors.blue,
              radius: 50,
              value: 40,
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
