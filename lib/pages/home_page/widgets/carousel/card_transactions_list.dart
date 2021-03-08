import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';
import './transaction_tile.dart';

class CardTransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const CardTransactionsList({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TransactionsList(transactions: transactions);
  }
}

class _TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const _TransactionsList({Key? key, required this.transactions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(child: Text('No transactions. Click in the upper right corner to start adding transactions.')),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: transactions.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => TransactionTile(
          transaction: transactions[index],
        ),
      );
    }
  }
}
