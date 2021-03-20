import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages.dart';

enum CardDetailAction { delete, edit }

class CardDetailActionSelector extends StatelessWidget {
  final CredictCard card;

  const CardDetailActionSelector({
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
          BlocProvider.of<CardsBloc>(context).add(CardDelete(card));
        }
      },
    );
  }
}
