import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: Center(
        child: Text('Login page'),
      ),
    );
  }
}
