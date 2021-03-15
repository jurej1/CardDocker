import 'package:flutter/material.dart';

class GridBase extends StatelessWidget {
  final List<Widget> children;

  const GridBase({Key? key, required this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        mainAxisExtent: 70,
      ),
      children: children,
    );
  }
}
