import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';

class TransactionsStatsGrid extends StatelessWidget {
  final BasicTransactionsStats stats;
  final Widget box = const SizedBox(height: 8);

  TransactionsStatsGrid({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        mainAxisExtent: 70,
      ),
      children: [
        _TextColumn(
          title: 'Biggest',
          content: '\$${stats.biggestTransaction.toStringAsFixed(0)}',
        ),
        _TextColumn(
          title: 'Smallest',
          content: stats.smallestTranasction.toStringAsFixed(0),
        ),
        _TextColumn(
          title: 'Total transactions',
          content: stats.numOfTransactions.toString(),
        ),
        _TextColumn(
          title: 'Positive transactions',
          content: stats.numTotalPositiveTransactions.toString(),
        ),
        _TextColumn(
          title: 'Total exspenses',
          content: stats.numTotalNegativeTransactions.toString(),
        ),
        _TextColumn(
          title: 'Last Month',
          content: stats.numTransactionsThisMonth.toString(),
        ),
        _TextColumn(
          title: 'Last 7 days',
          content: stats.numTransactionsThisWeek.toString(),
        ),
        _TextColumn(
          title: 'Today',
          content: stats.numTransactionsToday.toString(),
        ),
        _TextColumn(
          title: 'Total flow',
          content: '\$${stats.totalCashFlow.toStringAsFixed(0)}',
        ),
        _TextColumn(
          title: 'Negative flow',
          content: '\$${stats.totalNegativeCashFlow.toStringAsFixed(0)}',
          contentColor: Colors.red,
        ),
        _TextColumn(
          title: 'Positive flow',
          content: '\$${stats.totalPositiveCashFlow.toStringAsFixed(0)}',
          contentColor: Colors.green,
        ),
      ],
    );
  }
}

class _TextColumn extends StatelessWidget {
  final String title;
  final String content;
  final Color? contentColor;

  const _TextColumn({
    Key? key,
    required this.title,
    required this.content,
    this.contentColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                softWrap: true,
                maxLines: 2,
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                content,
                style: TextStyle(
                  color: contentColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
