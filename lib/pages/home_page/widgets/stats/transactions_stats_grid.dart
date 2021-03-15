import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class TransactionsStatsGrid extends StatelessWidget {
  final BasicTransactionsStats stats;

  TransactionsStatsGrid({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridBase(
      children: [
        TextColumn(
          title: 'Biggest',
          content: '\$${stats.biggestTransaction.toStringAsFixed(0)}',
        ),
        TextColumn(
          title: 'Smallest',
          content: "\$${stats.smallestTranasction.toStringAsFixed(0)}",
        ),
        TextColumn(
          title: 'Total transactions',
          content: stats.numOfTransactions.toString(),
        ),
        TextColumn(
          title: 'Positive transactions',
          content: stats.numTotalPositiveTransactions.toString(),
        ),
        TextColumn(
          title: 'Total exspenses',
          content: stats.numTotalNegativeTransactions.toString(),
        ),
        TextColumn(
          title: 'Last 30 Days',
          content: stats.numTransactionsThisMonth.toString(),
        ),
        TextColumn(
          title: 'Last 7 days',
          content: stats.numTransactionsThisWeek.toString(),
        ),
        TextColumn(
          title: 'Today',
          content: stats.numTransactionsToday.toString(),
        ),
        TextColumn(
          title: 'Total flow',
          content: '\$${stats.totalCashFlow.toStringAsFixed(0)}',
        ),
        TextColumn(
          title: 'Negative flow',
          content: '\$${stats.totalNegativeCashFlow.toStringAsFixed(0)}',
          contentColor: Colors.red,
        ),
        TextColumn(
          title: 'Positive flow',
          content: '\$${stats.totalPositiveCashFlow.toStringAsFixed(0)}',
          contentColor: Colors.green,
        ),
      ],
    );
  }
}
