import 'package:card_docker/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

class PasswordInput extends StatelessWidget {
  final double iconSize = 20;
  final FocusNode focusNode;

  const PasswordInput({Key key, @required this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignUpFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !state.isPasswordVisible,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, size: iconSize),
            hintText: 'Password',
            errorText: state.password.invalid ? 'Password to weak' : null,
            suffixIcon: IconButton(
              iconSize: iconSize,
              icon: state.isPasswordVisible ? const Icon(Icons.remove_red_eye) : _crossEyeIcon(),
              onPressed: () => BlocProvider.of<SignUpFormBloc>(context).add(SignUpPasswordVisibilityChange()),
            ),
          ),
        );
      },
    );
  }

  Widget _crossEyeIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.remove_red_eye),
        Icon(
          Icons.close,
          size: iconSize + 10,
        ),
      ],
    );
  }
}
