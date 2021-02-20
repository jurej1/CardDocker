import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/login_page/view/login_view.dart';
import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'login_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(
        firebaseAuthenticationRepository: RepositoryProvider.of<FirebaseAuthenticationRepository>(context),
      ),
      child: LoginView(),
    );
  }
}
