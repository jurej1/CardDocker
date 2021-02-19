import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

class EmailInput extends StatelessWidget {
  final double iconSize = 20;
  final FocusNode focusNode;

  const EmailInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email, size: iconSize),
            suffixIcon: _suffixIcon(state),
            errorText: state.email.invalid ? 'Not valid email address' : null,
          ),
          onChanged: (value) => BlocProvider.of<LoginFormBloc>(context).add(EmailChanged(value)),
        );
      },
    );
  }

  Widget _suffixIcon(LoginFormState state) {
    if (state.email.pure || state.email.invalid) {
      return null;
    } else {
      return Icon(
        Icons.check,
        size: iconSize,
      );
    }
  }
}
