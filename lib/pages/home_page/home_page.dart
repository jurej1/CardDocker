import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          ActionSelector(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              CardsCarousel(),
              Expanded(
                child: FilteredTransactionsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
