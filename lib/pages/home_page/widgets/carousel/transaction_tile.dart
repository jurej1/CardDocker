import 'package:flutter/material.dart';

import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/transaction.dart' as model;
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final model.Transaction _transaction;

  const TransactionTile({
    Key? key,
    required model.Transaction transaction,
  })   : _transaction = transaction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _LeadingIcon(
        amount: _transaction.amount,
      ),
      trailing: _TrailingData(
        amount: _transaction.amount,
        created: _transaction.created!,
      ),
      title: _TitleOutput(
        title: _transaction.title,
      ),
      subtitle: Text(transactionPurposeToString(_transaction.purpose)),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  final bool _isPositive;
  final opacity = 0.3;
  _LeadingIcon({
    Key? key,
    required num amount,
  })   : _isPositive = !amount.isNegative,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _isPositive ? Colors.green.withOpacity(opacity) : Colors.red.withOpacity(opacity),
      ),
      child: Icon(
        _isPositive ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
        color: _isPositive ? Colors.green : Colors.red,
        size: 30,
      ),
    );
  }
}

class _TitleOutput extends StatelessWidget {
  final String title;

  const _TitleOutput({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class _TrailingData extends StatelessWidget {
  final DateTime _created;
  final num amount;
  final String _sign;
  final bool _isPositive;

  _TrailingData({Key? key, required DateTime created, required this.amount})
      : _created = created,
        _sign = amount.isNegative ? '-' : '+',
        _isPositive = !amount.isNegative,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$_sign \$${amount.toStringAsFixed(0)}',
          style: TextStyle(
            color: _isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          DateFormat('MMM dd').format(_created),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
