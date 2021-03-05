import 'package:card_docker/blocs/add_transaction_form/add_transaction_form_bloc.dart';
import 'package:card_docker/pages/add_transaction/widgets/card_selector.dart';
import 'package:card_docker/pages/add_transaction/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
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

    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionAmountUnfocused());
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add transaction'),
        actions: [
          _SubmitButton(),
        ],
      ),
      body: BlocListener<AddTransactionFormBloc, AddTransactionFormState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            TitleInput(focusNode: _titleFocusNode),
            const SizedBox(height: 10),
            NoteInput(),
            const SizedBox(height: 10),
            AmountInput(focusNode: _amountFocusNode),
            const SizedBox(height: 10),
            CardSelector(),
            const SizedBox(height: 10),
            TransactionPurposeSelector(),
            const SizedBox(height: 10),
            CreatedSelector(),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        final canSubmit = state.status.isValidated;
        return TextButton(
          child: state.status.isSubmissionInProgress
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text(
                  'SUBMIT',
                  style: TextStyle(color: canSubmit ? Colors.white : Colors.grey),
                ),
          onPressed: canSubmit
              ? () {
                  if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
                  BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionSubmitForm());
                }
              : null,
        );
      },
    );
  }
}
