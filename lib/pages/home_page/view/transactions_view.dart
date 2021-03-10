import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is TransactionsFailure) {
          return Center(
            child: Text('Oops something went wrong'),
          );
        } else if (state is TransactionsLoadSuccess) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Transactions'),
              actions: [
                ActionSelector(),
              ],
            ),
            body: TransactionsList(transactions: state.transactions),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
