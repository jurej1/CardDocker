import 'package:card_docker/pages/pages.dart';
import 'package:card_docker/repositories/authentication_repository/authentication_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/transactions_repository/src/firebase_transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';

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
        BlocProvider<HomePageCubit>(
          create: (context) => HomePageCubit(),
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
        ),
        BlocProvider<TransactionsStatsBloc>(
          create: (context) => TransactionsStatsBloc(
            transactionsBloc: BlocProvider.of<TransactionsBloc>(context),
            transactionsRepository: RepositoryProvider.of<FirebaseTransactionsRepository>(context),
          ),
        ),
        BlocProvider<CardsStatsBloc>(
          create: (context) => CardsStatsBloc(
            firebaseCredictCardRepository: RepositoryProvider.of<FirebaseCredictCardRepository>(context),
            cardsBloc: BlocProvider.of<CardsBloc>(context),
          ),
        ),
      ],
      child: _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  final _navigator = GlobalKey<NavigatorState>();

  NavigatorState? get _navigatorState => _navigator.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      navigatorKey: _navigator,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (contex, state) {
            if (state is Authenticated) {
              BlocProvider.of<TransactionsBloc>(context).add(LoadTransactions(state.user.id!));
              BlocProvider.of<CardsBloc>(context).add(LoadCards(state.user.id!));
              _navigatorState?.pushNamedAndRemoveUntil(HomePage.routeName, (_) => false);
            } else if (state is Unauthenticated) {
              _navigatorState?.pushNamedAndRemoveUntil(LoginPage.routeName, (_) => false);
            }
          },
          child: child,
        );
      },
      initialRoute: SplashPage.routeName,
      routes: {
        HomePage.routeName: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CarouselBloc>(
                lazy: false,
                create: (context) => CarouselBloc(
                  cardsBloc: BlocProvider.of<CardsBloc>(context),
                  transactionsBloc: BlocProvider.of<TransactionsBloc>(context),
                ),
              ),
              BlocProvider<StatsViewBloc>(
                lazy: false,
                create: (context) => StatsViewBloc(
                  transactionsStatsBloc: BlocProvider.of<TransactionsStatsBloc>(context),
                  cardsStatsBloc: BlocProvider.of<CardsStatsBloc>(context),
                ),
              ),
              BlocProvider<TransactionDataBarChartBloc>(
                lazy: false,
                create: (context) => TransactionDataBarChartBloc(
                  statsViewBloc: BlocProvider.of<StatsViewBloc>(context),
                ),
              ),
              BlocProvider<TierStatusBloc>(
                lazy: false,
                create: (context) => TierStatusBloc(
                  transactionsBloc: BlocProvider.of<TransactionsBloc>(context),
                ),
              )
            ],
            child: HomePage(),
          );
        },
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        SplashPage.routeName: (context) => SplashPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
        AddCredictCardPage.routeName: (context) => AddCredictCardPage(),
        AddTransactionPage.routeName: (context) => AddTransactionPage(),
      },
    );
  }
}
