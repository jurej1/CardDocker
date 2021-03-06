import 'package:card_docker/blocs/add_credict_card_form/add_credict_card_form_bloc.dart';
import 'package:card_docker/blocs/auth_bloc/auth_bloc.dart';
import 'package:card_docker/pages/add_credict_card/view/view.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCredictCardPage extends StatelessWidget {
  static const routeName = 'add_credict_card_page';

  final CredictCard? credictCard;

  const AddCredictCardPage({Key? key, this.credictCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCredictCardFormBloc>(
      create: (context) => AddCredictCardFormBloc(
        intialState: credictCard == null ? AddCredictCardFormState.add() : AddCredictCardFormState.edit(credictCard!),
        authBloc: BlocProvider.of<AuthBloc>(context),
        firebaseCredictCardRepository: RepositoryProvider.of<FirebaseCredictCardRepository>(context),
      ),
      child: AddCredictCardView(),
    );
  }
}
