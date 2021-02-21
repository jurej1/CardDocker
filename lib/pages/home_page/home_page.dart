import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
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
          FlatButton(
            child: Text('Logout'),
            textColor: Colors.white,
            onPressed: () => BlocProvider.of<AuthBloc>(context).add(LogoutRequested()),
          ),
        ],
      ),
      body: BlocBuilder<CardsBloc, CardsState>(
        builder: (context, state) {
          if (state is CardsLoading) {
            return Center(
              child: Text('Loading'),
            );
          } else if (state is CardsLoadFailure) {
            return Center(
              child: Text('Something went wrong'),
            );
          } else if (state is CardsLoadSuccess) {
            return CardsList(cards: state.cards);
          }

          return Container();
        },
      ),
    );
  }
}
