import 'package:flutter/material.dart';

class SwitchView extends StatelessWidget {
  final String title;
  final String routeName;

  const SwitchView({Key key, @required this.title, @required this.routeName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: MediaQuery.of(context).size.width,
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.black38),
        child: Text(title),
        textColor: Colors.grey[600],
        onPressed: () => Navigator.of(context).pushReplacementNamed(routeName),
      ),
    );
  }
}
