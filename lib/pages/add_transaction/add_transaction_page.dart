import 'package:card_docker/blocs/add_transaction_form/add_transaction_form_bloc.dart';
import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/add_transaction/view.dart/add_transaction_view.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionPage extends StatelessWidget {
  static const routeName = 'add_transaction_page';

  final Transaction? transaction;

  const AddTransactionPage({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTransactionFormBloc(
        authBloc: BlocProvider.of<AuthBloc>(context),
        firebaseTransactionsRepository: RepositoryProvider.of<FirebaseTransactionsRepository>(context),
        initialState: transaction == null
            ? AddTransactionFormState.add()
            : AddTransactionFormState.edit(
                cards: (BlocProvider.of<CardsBloc>(context).state as CardsLoadSuccess).cards,
                transaction: transaction!,
              ),
      ),
      child: AddTransactionView(),
    );
  }
}
