import 'package:card_docker/pages/home_page/view/view.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          ActionSelector(),
        ],
      ),
      body: CarouselView(),
    );
  }
}
