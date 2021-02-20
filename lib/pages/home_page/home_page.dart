import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
