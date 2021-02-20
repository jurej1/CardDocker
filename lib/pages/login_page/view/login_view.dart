import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/login_page/widgets/widgets.dart';
import 'package:card_docker/pages/sign_up/sign_up_page.dart';
import 'package:card_docker/widgets/or_divider.dart';
import 'package:card_docker/widgets/switch_view_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        BlocProvider.of<LoginFormBloc>(context).add(EmailUnfocused());
        _emailFocusNode.requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        BlocProvider.of<LoginFormBloc>(context).add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EmailInput(focusNode: _emailFocusNode),
          const SizedBox(height: 4),
          PasswordInput(focusNode: _passwordFocusNode),
          const SizedBox(height: 20),
          LogInSubmitButton(),
          const SizedBox(height: 10),
          OrDivider(),
          const SizedBox(height: 10),
          SwitchView(routeName: SignUpPage.routeName, title: 'Sign up'),
        ],
      ),
    );
  }
}
