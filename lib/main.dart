import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/transactions_repository/src/firebase_transaction_repository.dart';
import 'package:card_docker/simple_bloc_observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'app.dart';
import 'repositories/authentication_repository/authentication_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await firebase_core.Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FirebaseAuthenticationRepository(firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider(
          create: (context) => FirebaseCredictCardRepository(),
        ),
        RepositoryProvider(
          create: (context) => FirebaseTransactionsRepository(),
        ),
      ],
      child: App(),
    ),
  );
}
