import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/add_transaction/add_transaction_page.dart';
import 'package:card_docker/repositories/transactions_repository/src/enums/transactions_purpose.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void showTransactionDetailDialog({
  required BuildContext context,
  required Transaction transaction,
}) {
  showDialog(
    context: context,
    builder: (context) {
      final box = SizedBox(
        height: 8,
      );
      return AlertDialog(
        title: Text('Transactions Details'),
        content: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              _OutputRow(
                title: 'Title',
                content: transaction.title,
              ),
              box,
              _OutputRow(
                title: 'Amount',
                content: '\$ ${transaction.amount.toStringAsFixed(2)}',
              ),
              box,
              _OutputRow(
                title: 'Created',
                content: DateFormat('dd MMMM yyyy hh:dd').format(transaction.created!),
              ),
              box,
              _OutputRow(
                title: 'Purpose',
                content: transactionPurposeToString(transaction.purpose),
              ),
              box,
              if (transaction.note != null && transaction.note!.isNotEmpty) ...{
                _OutputRow(title: 'Note', content: transaction.note!),
              }
            ],
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(AddTransactionPage.routeName, arguments: transaction);
                },
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<TransactionsBloc>(context).add(DeleteTransaction(transaction));
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

class _OutputRow extends StatelessWidget {
  final String title;
  final String content;

  const _OutputRow({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        Text(content),
      ],
    );
  }
}
