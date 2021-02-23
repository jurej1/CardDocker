import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteInput extends StatelessWidget {
  final FocusNode focusNode;

  const NoteInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          initialValue: state.note.value,
          maxLength: 100,
          autocorrect: false,
          onChanged: (value) => BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardNoteChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Note',
            helperText: 'Card name or something that will help you differentiate the cards.',
            helperMaxLines: 2,
            errorText: state.note.invalid ? 'Min 4 characters.' : null,
          ),
        );
      },
    );
  }
}
