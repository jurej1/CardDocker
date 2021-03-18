import 'package:card_docker/constants/message.dart';
import 'package:flutter/material.dart';

class AboutUsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.info),
      title: Text('About us'),
      onTap: () => _showAboutUsDialog(context),
    );
  }

  void _showAboutUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('About us'),
          content: Text(Message.cardDockerContact),
        );
      },
    );
  }
}
