import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

class PasswordInput extends StatelessWidget {
  final double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextField(
          obscureText: state.isPasswordVisible,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(
              Icons.lock,
              size: iconSize,
            ),
            suffixIcon: IconButton(
              iconSize: iconSize,
              icon: state.isPasswordVisible ? const Icon(Icons.remove_red_eye) : _crossEyeIcon(),
              onPressed: () {
                BlocProvider.of<LoginFormBloc>(context).add(ChangePasswordVisibility());
              },
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
