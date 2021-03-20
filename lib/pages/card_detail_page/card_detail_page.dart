import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/add_credict_card/add_credict_card_page.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';

class CardDetailPage extends StatelessWidget {
  static const routeName = 'card_detail_page';

  final box = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCardCubit, DetailCardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Credict card'),
            actions: [
              _ActionSelector(
                card: state.card,
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              CredictCardWidget(card: state.card),
              box,
              _TransactionsList(),
            ],
          ),
        );
      },
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

enum CardDetailAction { delete, edit }

class _ActionSelector extends StatelessWidget {
  final CredictCard card;

  const _ActionSelector({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CardDetailAction>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) {
        return CardDetailAction.values.map((e) {
          return PopupMenuItem<CardDetailAction>(
            value: e,
            child: Text(describeEnum(e).toUpperCase()),
          );
        }).toList();
      },
      onSelected: (action) {
        if (action == CardDetailAction.edit) {
          Navigator.of(context).pushNamed(AddCredictCardPage.routeName, arguments: card);
        } else if (action == CardDetailAction.delete) {
          //TODO
        }
      },
    );
  }
}
