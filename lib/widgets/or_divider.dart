import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _line(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'or',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        _line(),
      ],
    );
  }

  Widget _line() {
    return Expanded(
      child: Container(
        color: Colors.grey[350],
        height: 1.5,
      ),
    );
  }
}
