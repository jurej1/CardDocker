import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const InputCard({Key key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: child,
        ),
      ),
    );
  }
}
