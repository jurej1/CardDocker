import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/sign_up/view/sign_up_view.dart';
import 'package:card_docker/repositories/authentication_repository/src/firebase_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = 'sign_up_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpFormBloc(
        firebaseAuthenticationRepository: RepositoryProvider.of<FirebaseAuthenticationRepository>(context),
      ),
      child: SignUpView(),
    );
  }
}
