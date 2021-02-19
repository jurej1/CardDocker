import 'package:flutter/material.dart';

class SwitchView extends StatelessWidget {
  final String title;
  final String routeName;

  const SwitchView({Key key, @required this.title, @required this.routeName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(title),
      onPressed: () => Navigator.of(context).pushReplacementNamed(routeName),
    );
  }
}
