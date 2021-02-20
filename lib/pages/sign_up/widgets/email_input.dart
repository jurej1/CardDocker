import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

class EmailInput extends StatelessWidget {
  final double iconSize = 20;
  final FocusNode focusNode;

  const EmailInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignUpFormState>(
      builder: (contex, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, size: iconSize),
            hintText: 'Email',
            errorText: state.email.invalid ? 'Not valid email address' : null,
            suffixIcon: _suffixIcon(state),
          ),
          onChanged: (value) => BlocProvider.of<SignUpFormBloc>(context).add(SignUpEmailChanged(value.trim())),
        );
      },
    );
  }

  Widget _suffixIcon(SignUpFormState state) {
    if (state.email.pure || state.email.invalid) {
      return null;
    } else {
      return Icon(Icons.check, size: iconSize);
    }
  }
}
