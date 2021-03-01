import 'package:card_docker/blocs/add_credict_card_form/add_credict_card_form_bloc.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCredictCardView extends StatefulWidget {
  @override
  _AddCredictCardViewState createState() => _AddCredictCardViewState();
}

class _AddCredictCardViewState extends State<AddCredictCardView> {
  final FocusNode _noteFocusNode = FocusNode();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _noteFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add credict card'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: () => BlocProvider.of<AddCredictCardFormBloc>(context).add(CrediCardFormSubmit()),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          NoteInput(focusNode: _noteFocusNode),
          const SizedBox(height: 13),
          AmountInput(focusNode: _focusNode),
          const SizedBox(height: 13),
          CompanySelector(),
          const SizedBox(height: 13),
          TypeSelector(),
          const SizedBox(height: 13),
          ColorSelector(),
        ],
      ),
    );
  }
}
