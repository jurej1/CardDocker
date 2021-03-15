import 'package:flutter/material.dart';

class StatCardBase extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const StatCardBase({
    Key? key,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: backgroundColor,
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
