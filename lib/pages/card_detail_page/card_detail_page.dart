import 'package:card_docker/pages/card_detail_page/widgets/widgets.dart';
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
              CardDetailActionSelector(
                card: state.card,
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              CredictCardWidget(card: state.card),
              box,
              FilteredTransactionsList(),
            ],
          ),
        );
      },
    );
  }
}
