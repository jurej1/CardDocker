import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = 'settings_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Settings page',
        ),
      ),
    );
  }
}
