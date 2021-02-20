import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _displayNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _displayNameFocusNode.addListener(() {
      if (!_displayNameFocusNode.hasFocus) {
        BlocProvider.of<SignUpFormBloc>(context).add(DisplayNameUnfocused());
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        BlocProvider.of<SignUpFormBloc>(context).add(SignUpEmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        BlocProvider.of<SignUpFormBloc>(context).add(SignUpPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _displayNameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DisplayNameInput(focusNode: _displayNameFocusNode),
            const SizedBox(height: 4),
            EmailInput(focusNode: _emailFocusNode),
            const SizedBox(height: 4),
            PasswordInput(focusNode: _passwordFocusNode),
            const SizedBox(height: 20),
            SignUpSubmitButton(),
          ],
        ),
      ),
    );
  }
}
