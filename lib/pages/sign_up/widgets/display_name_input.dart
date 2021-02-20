import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

class DisplayNameInput extends StatelessWidget {
  final double iconSize = 20;
  final FocusNode focusNode;

  const DisplayNameInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignUpFormState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          initialValue: state.displayName.value,
          autocorrect: false,
          keyboardType: TextInputType.name,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, size: iconSize),
            hintText: 'Name',
            errorText: state.displayName.invalid ? 'Min 5 characters.' : null,
          ),
          onChanged: (value) => BlocProvider.of<SignUpFormBloc>(context).add(DisplayNameChanged(value.trim())),
        );
      },
    );
  }
}
