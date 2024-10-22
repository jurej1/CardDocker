import 'package:card_docker/pages/add_credict_card/add_credict_card_page.dart';
import 'package:card_docker/pages/add_transaction/add_transaction_page.dart';
import 'package:flutter/material.dart';

enum Action {
  addTransaction,
  addCard,
}

class ActionSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
      itemBuilder: (context) {
        return Action.values.map((action) {
          return PopupMenuItem<Action>(
            child: Text(_actionText(action)),
            value: action,
          );
        }).toList();
      },
      onSelected: (actionSelected) {
        if (actionSelected == Action.addCard) {
          Navigator.of(context).pushNamed(AddCredictCardPage.routeName);
        } else if (actionSelected == Action.addTransaction) {
          Navigator.of(context).pushNamed(AddTransactionPage.routeName);
        }
      },
    );
  }

  String _actionText(Action action) {
    if (action == Action.addCard) {
      return 'Add card';
    } else if (action == Action.addTransaction) {
      return 'Add transaction';
    }
    return '';
  }
}
