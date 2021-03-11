import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/home_page/widgets/stats/stat_card_base.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsViewBloc, StatsViewState>(
      builder: (context, state) {
        if (state is StatsViewLoadSuccess) {
          return _List(
            credictCardsStats: state.credictCardsStats,
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _List extends StatelessWidget {
  final CredictCardsStats credictCardsStats;

  const _List({Key? key, required this.credictCardsStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatCardBase(
      backgroundColor: Colors.blue,
      child: Column(),
    );
  }
}
