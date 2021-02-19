import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/pages/home_page/home_page.dart';
import 'package:card_docker/pages/login_page/login_page.dart';
import 'package:card_docker/pages/splash_page/splash_page.dart';
import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            firebaseAuthenticationRepository: RepositoryProvider.of<FirebaseAuthenticationRepository>(context),
          )..add(AppStarted()),
        ),
      ],
      child: _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  final _navigator = GlobalKey<NavigatorState>();

  NavigatorState get _navigatorState => _navigator.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigator,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (contex, state) {
            // if (state is Authenticated) {
            //   _navigatorState.pushNamedAndRemoveUntil(HomePage.routeName, (_) => false);
            // } else if (state is Unauthenticated) {
            //   _navigatorState.pushNamedAndRemoveUntil(LoginPage.routeName, (_) => false);
            // }
          },
          child: LoginPage(), // Do not forget to change this to state
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        LoginPage.routeName: (context) => LoginPage(),
      },
    );
  }
}
