import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: ListView(
        children: [
          CardsCarousel(),
        ],
      ),
    );
  }
}
