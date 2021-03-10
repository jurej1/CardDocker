import 'package:card_docker/pages/home_page/widgets/transactions/transaction_tile.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Text('Click in the upper right corner to start adding transactions'),
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: transactions.length,
        itemBuilder: (context, index) => TransactionTile(
          transaction: transactions[index],
        ),
      );
    }
  }
}
