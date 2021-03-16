import 'package:flutter/material.dart';

class ChartBoard extends StatelessWidget {
  final int length;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Color? backgroundColor;

  const ChartBoard({
    Key? key,
    required this.length,
    required this.itemBuilder,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor ?? Colors.blue.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _title(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              itemBuilder: itemBuilder,
              itemCount: length,
            ),
          ),
        ],
      ),
    );
  }

  String _title() {
    switch (length) {
      case 1:
        return 'Top one';
      case 2:
        return 'Top two';
      case 3:
        return 'Top three';
      case 4:
        return 'Top four';
      default:
        return 'Top five';
    }
  }
}
