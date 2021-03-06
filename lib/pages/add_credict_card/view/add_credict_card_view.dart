import 'package:card_docker/blocs/add_credict_card_form/add_credict_card_form_bloc.dart';
import 'package:card_docker/enums/enums.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
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
          _SubmitButton(),
        ],
      ),
      body: BlocListener<AddCredictCardFormBloc, AddCredictCardFormState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();

            if (state.mode == Mode.add) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Credict card successfully added.'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state.mode == Mode.edit) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Credict card successfully edited.'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Submission failed. Please try again.'),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
          }
        },
        child: ListView(
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
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        final isLoading = state.status.isSubmissionInProgress;
        final canSubmit = state.status.isValidated;

        return TextButton(
          onPressed: canSubmit
              ? isLoading
                  ? null
                  : () => BlocProvider.of<AddCredictCardFormBloc>(context).add(CrediCardFormSubmit())
              : null,
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  'SUBMIT',
                  style: TextStyle(color: canSubmit ? Colors.white : Colors.grey),
                ),
        );
      },
    );
  }
}
