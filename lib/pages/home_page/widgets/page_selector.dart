import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class PageSelector extends StatelessWidget {
//   final pages = HomePageType.values;

//   const PageSelector();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomePageCubit, HomePageType>(
//       builder: (context, state) {
//         return BottomNavigationBar(
//           currentIndex: pages.indexOf(state),
//           onTap: (index) => BlocProvider.of<HomePageCubit>(context).updatePage(index),
//           showUnselectedLabels: false,
//           showSelectedLabels: false,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Theme.of(context).primaryColor,
//           unselectedItemColor: Colors.grey,
//           items: pages.map(
//             (e) {
//               return BottomNavigationBarItem(
//                 icon: Icon(_icon(e)),
//                 label: _label(e),
//               );
//             },
//           ).toList(),
//         );
//       },
//     );
//   }

//   IconData _icon(HomePageType type) {
//     if (type == HomePageType.carousel) {
//       return Icons.home;
//     } else if (type == HomePageType.profile) {
//       return Icons.person;
//     } else if (type == HomePageType.stats) {
//       return Icons.graphic_eq;
//     } else {
//       return Icons.money;
//     }
//   }

//   String _label(HomePageType type) {
//     if (type == HomePageType.carousel) {
//       return 'Home';
//     } else if (type == HomePageType.profile) {
//       return 'Profile';
//     } else if (type == HomePageType.stats) {
//       return 'Stats';
//     } else {
//       return 'Transactions';
//     }
//   }
// }

class PageSelector extends StatelessWidget with PreferredSizeWidget {
  static const _pages = HomePageType.values;
  static const _radius = Radius.circular(16);
  const PageSelector();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageType>(
      builder: (context, state) {
        final selected = state;

        return Material(
          type: MaterialType.canvas,
          elevation: 15,
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: _radius,
            topRight: _radius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _pages.map(
              (e) {
                return IconButton(
                  icon: Icon(_icon(e)),
                  color: selected == e ? Colors.blue : Colors.grey,
                  onPressed: () => BlocProvider.of<HomePageCubit>(context).updatePage(_pages.indexOf(e)),
                );
              },
            ).toList(),
          ),
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

  String _label(HomePageType type) {
    if (type == HomePageType.carousel) {
      return 'Home';
    } else if (type == HomePageType.profile) {
      return 'Profile';
    } else if (type == HomePageType.stats) {
      return 'Stats';
    } else {
      return 'Transactions';
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kBottomNavigationBarHeight);
}
