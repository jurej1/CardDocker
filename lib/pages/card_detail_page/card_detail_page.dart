import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardDetailPage extends StatelessWidget {
  static const routeName = 'card_detail_page';

  final box = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final card = ModalRoute.of(context)!.settings.arguments as CredictCard;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CredictCardWidget(card: card),
          box,
          _TransactionsList(),
        ],
      ),
    );
  }
}

class _TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTransactionsBloc, FilteredTransactionsState>(
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
