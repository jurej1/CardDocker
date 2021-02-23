import 'package:card_docker/pages/add_credict_card/widgets/company_selector.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
        title: Text('Add credict card'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          NoteInput(focusNode: _noteFocusNode),
          BalanceInput(focusNode: _focusNode),
          CompanySelector(),
        ],
      ),
    );
  }
}
