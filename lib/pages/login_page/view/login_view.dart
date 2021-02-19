import 'package:card_docker/pages/login_page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            EmailInput(focusNode: _emailFocusNode),
            PasswordInput(focusNode: _passwordFocusNode),
          ],
        ),
      ),
    );
  }
}
