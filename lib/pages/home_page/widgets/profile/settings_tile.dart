import 'package:card_docker/pages/pages.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.settings),
      title: const Text('Settings'),
      onTap: () {
        Navigator.of(context).pushNamed(SettingsPage.routeName);
      },
    );
  }
}
