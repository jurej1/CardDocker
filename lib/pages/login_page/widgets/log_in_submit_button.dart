import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 43,
          child: RaisedButton(
            onPressed: () {
              if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
              BlocProvider.of<LoginFormBloc>(context).add(LoginFormSubmit());
            },
            child: Text('Log in'),
            textColor: Colors.white,
          ),
        );
      },
    );
  }
}
