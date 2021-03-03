import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.note.value,
          autocorrect: false,
          minLines: 2,
          maxLines: double.maxFinite.toInt(),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Description',
            errorText: state.note.invalid ? 'Max characters 300.' : null,
          ),
          onChanged: (value) => BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionNoteChanged(value)),
        );
      },
    );
  }
}
