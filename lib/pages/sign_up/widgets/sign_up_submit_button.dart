import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignUpFormState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 43,
          child:  RaisedButton(
            onPressed: () {
              if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
              BlocProvider.of<SignUpFormBloc>(context).add(SignUpFormSubmit());
            },
            child:  state.status.isSubmissionInProgress ? Center(child: CircularProgressIndicator(),): Text('Sign in'),
            textColor: Colors.white,
          ),
        );
      },
    );
  }
}
