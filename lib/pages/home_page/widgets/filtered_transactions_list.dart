import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredTransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselBloc, CarouselState>(
      builder: (context, state) {
        if (state is CarouselLoading) {
          return Text('Loading');
        } else if (state is CarouselLoadSuccess) {
          return _TransactionsList(transactions: state.currentCardTransactions!);
        } else if (state is CarouselLoadFail) {
          return Text('Failed');
        } else {
          return Container();
        }
      },
    );
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
