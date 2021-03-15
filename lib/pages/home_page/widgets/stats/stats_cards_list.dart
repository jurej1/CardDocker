import 'package:card_docker/blocs/stats_view_bloc/stats_view_bloc.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight * 0.6),
            _TransactionsStatsCard(),
            const SizedBox(height: 15),
            _CardsStatsCard(),
          ],
        ),
      ),
    );
  }
}

class _TransactionsStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsViewBloc, StatsViewState>(
      builder: (context, state) {
        if (state is StatsViewLoadSuccess) {
          return StatCardBase(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TransactionsStatsGrid(stats: state.transactionsStats),
                const SizedBox(height: 20),
                TransactionsPieChart(purposeStats: state.transactionsStats.purposeStats),
                const SizedBox(height: 20),
                TransactionPeriodChart(),
                const SizedBox(height: 20),
                LastTransactionAdded(transaction: state.transactionsStats.lastTransactionAdded),
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

class _CardsStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsViewBloc, StatsViewState>(
      builder: (context, state) {
        if (state is StatsViewLoadSuccess) {
          return Container(
            color: Colors.green.withOpacity(0.3),
            child: Text('Cards stats'),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
