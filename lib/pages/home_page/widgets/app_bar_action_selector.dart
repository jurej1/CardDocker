import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/pages/add_credict_card/add_credict_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Action {  addCard, logout }

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
        } else if (actionSelected == Action.logout) {
          BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
        }
      },
    );
  }

  String _actionText(Action action) {
    if (action == Action.addCard) {
      return 'Add card';
    } else if (action == Action.logout) {
      return 'Logout';
    }
    return '';
  }
}
