import 'package:card_docker/pages/home_page/widgets/transactions/transaction_tile.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:flutter/material.dart';

class LastTransactionAdded extends StatelessWidget {
  final Transaction? transaction;

  const LastTransactionAdded({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transaction == null) {
      return Container();
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last transction added',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          TransactionTile(transaction: transaction!),
        ],
      );
    }
  }
}
