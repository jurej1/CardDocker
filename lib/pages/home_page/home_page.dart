import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/enums/enums.dart';
import 'package:card_docker/pages/home_page/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home_page';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageType>(
      builder: (context, state) {
        if (state == HomePageType.carousel) {
          return CarouselView();
        } else if (state == HomePageType.transactions) {
          return TransactionsView();
        } else if (state == HomePageType.stats) {
          return StatsView();
        } else {
          return ProfileView();
        }
      },
    );
  }
}
