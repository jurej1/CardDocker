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
              physics: const ClampingScrollPhysics(),
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
          return StatCardBase(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                CredictCardsStatsGrid(stats: state.credictCardsStats),
                const SizedBox(height: 20),
                CredictCardTypePieChart(purposeStats: state.credictCardsStats.purposeStats),
                const SizedBox(height: 20),
                CredictCardsStatsList(
                  credictCards: state.credictCardsStats.cardsWithSmallAmount,
                  title: 'Cards running low...',
                ),
                const SizedBox(height: 20),
                CredictCardsStatsList(
                  credictCards: state.credictCardsStats.cardsWithNegativeBalance,
                  title: 'Cards running very very low...',
                ),
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
