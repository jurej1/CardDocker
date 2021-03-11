import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

import 'transactions_stats_grid.dart';

class TransactionsStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsViewBloc, StatsViewState>(
      builder: (context, state) {
        if (state is StatsViewLoadSuccess) {
          return TransactionsStatsGrid(
            stats: state.transactionsStats,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
