import 'package:card_docker/blocs/transactions_bloc/transactions_bloc_bloc.dart';
import 'package:card_docker/pages/add_credict_card/add_credict_card_page.dart';
import 'package:card_docker/pages/add_transaction/add_transaction_page.dart';
import 'package:card_docker/pages/home_page/home_page.dart';
import 'package:card_docker/pages/login_page/login_page.dart';
import 'package:card_docker/pages/sign_up/sign_up_page.dart';
import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/transactions_repository/src/firebase_transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'pages/splash_page/splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            firebaseAuthenticationRepository: RepositoryProvider.of<FirebaseAuthenticationRepository>(context),
          )..add(AppStarted()),
        ),
        BlocProvider<CardsBloc>(
          create: (context) => CardsBloc(
            firebaseCredictCardRepository: RepositoryProvider.of<FirebaseCredictCardRepository>(context),
          ),
        ),
        BlocProvider<TransactionsBloc>(
          create: (context) => TransactionsBloc(
            firebaseTransactionsRepository: RepositoryProvider.of<FirebaseTransactionsRepository>(context),
          ),
        )
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
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      navigatorKey: _navigator,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (contex, state) {
            if (state is Authenticated) {
              BlocProvider.of<TransactionsBloc>(context).add(LoadTransactions(state.user.id));
              BlocProvider.of<CardsBloc>(context).add(LoadCards(state.user.id));
              _navigatorState.pushNamedAndRemoveUntil(HomePage.routeName, (_) => false);
            } else if (state is Unauthenticated) {
              _navigatorState.pushNamedAndRemoveUntil(LoginPage.routeName, (_) => false);
            }
          },
          child: child,
        );
      },
      initialRoute: SplashPage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        SplashPage.routeName: (context) => SplashPage(),
        AddCredictCardPage.routeName: (context) => AddCredictCardPage(),
        AddTransactionPage.routeName: (context) => AddTransactionPage(),
      },
    );
  }
}
