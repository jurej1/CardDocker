import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../or_divider.dart';
import '../switch_view_button.dart';
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
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        BlocProvider.of<SignUpFormBloc>(context).add(SignUpEmailUnfocused());
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DisplayNameInput(focusNode: _displayNameFocusNode),
            const SizedBox(height: 4),
            EmailInput(focusNode: _emailFocusNode),
            const SizedBox(height: 4),
            PasswordInput(focusNode: _passwordFocusNode),
            const SizedBox(height: 20),
            SignUpSubmitButton(),
            const SizedBox(height: 10),
            OrDivider(),
            const SizedBox(height: 10),
            SwitchView(routeName: LoginPage.routeName, title: 'Log in'),
          ],
        ),
      ),
    );
  }
}
