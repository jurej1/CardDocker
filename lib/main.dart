import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'repositories/authentication_repository/authentication_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RepositoryProvider(
      create: (_) => FirebaseAuthenticationRepository(),
      child: App(),
    ),
  );
}
