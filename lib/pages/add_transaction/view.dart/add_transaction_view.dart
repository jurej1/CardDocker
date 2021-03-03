import 'package:card_docker/blocs/add_transaction_form/add_transaction_form_bloc.dart';
import 'package:card_docker/pages/add_transaction/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionView extends StatefulWidget {
  @override
  _AddTransactionViewState createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionTitleUnfocused());
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add transaction'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          TitleInput(focusNode: _titleFocusNode),
          const SizedBox(height: 10),
          NoteInput(),
          const SizedBox(height: 10),
          AmountInput(focusNode: _amountFocusNode),
          const SizedBox(height: 10),
          CardInput(),
          const SizedBox(height: 10),
          TransactionPurposeInput(),
        ],
      ),
    );
  }
}
