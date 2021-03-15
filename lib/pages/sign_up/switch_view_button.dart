import 'package:flutter/material.dart';

class SwitchView extends StatelessWidget {
  final String title;
  final String routeName;

  const SwitchView({Key? key, required this.title, required this.routeName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: ButtonStyle(
            side: MaterialStateProperty.all(
          BorderSide(color: Colors.black26),
        )),
        child: Text(
          title,
          style: TextStyle(color: Colors.grey[600]),
        ),
        onPressed: () => Navigator.of(context).pushReplacementNamed(routeName),
      ),
    );
  }
}
