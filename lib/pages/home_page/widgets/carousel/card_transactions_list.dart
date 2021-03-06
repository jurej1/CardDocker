import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext buildContext) {
    if (transactions.isEmpty) {
      return Text('No transactions');
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(transactions[index].amount.toString()),
          );
        },
      );
    }
  }
}
