import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredTransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTransactionsCubit, FilteredTransactionsState>(
      builder: (context, state) {
        if (state is FilteredTransactionsLoadSuccess) {
          if (state.transactions.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withOpacity(0.25),
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              child: TransactionsList(transactions: state.transactions),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
