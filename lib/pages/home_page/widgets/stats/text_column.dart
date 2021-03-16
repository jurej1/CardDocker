import 'package:flutter/material.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String content;
  final Color? contentColor;

  const TextColumn({
    Key? key,
    required this.title,
    required this.content,
    this.contentColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title.isEmpty ? 'NAN' : title,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            child: Transform.scale(
              scale: 0.85,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  content,
                  style: TextStyle(
                    color: contentColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
