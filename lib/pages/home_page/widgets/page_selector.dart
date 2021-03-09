import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageSelector extends StatelessWidget {
  final pages = HomePageType.values;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageType>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: pages.indexOf(state),
          onTap: (index) => BlocProvider.of<HomePageCubit>(context).updatePage(index),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: pages.map(
            (e) {
              return BottomNavigationBarItem(
                icon: Icon(_icon(e)),
                label: e.toString(),
              );
            },
          ).toList(),
        );
      },
    );
  }

  IconData _icon(HomePageType type) {
    if (type == HomePageType.carousel) {
      return Icons.home;
    } else if (type == HomePageType.profile) {
      return Icons.person;
    } else if (type == HomePageType.stats) {
      return Icons.graphic_eq;
    } else {
      return Icons.money;
    }
  }
}
