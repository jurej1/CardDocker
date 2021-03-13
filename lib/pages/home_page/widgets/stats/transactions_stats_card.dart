import 'package:card_docker/pages/home_page/widgets/stats/stat_card_base.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';
import 'package:fl_chart/fl_chart.dart';
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
          return StatCardBase(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TransactionsStatsGrid(stats: state.transactionsStats),
                const SizedBox(height: 20),
                TransactionsChart(purposeStats: state.transactionsStats.purposeStats),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
