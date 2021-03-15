import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StatsViewBloc, StatsViewState>(
        builder: (context, state) {
          if (state is StatsViewLoading) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else if (state is StatsViewLoadSuccess) {
            return StatsCardsList();
          } else if (state is StatsViewFailure) {
            return Center(
              child: Text('Oops something went wrong'),
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: const PageSelector(),
    );
  }
}
