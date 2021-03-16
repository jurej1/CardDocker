import 'package:flutter/material.dart';

class NameOutput extends StatelessWidget {
  final String? name;
  const NameOutput({
    Key? key,
    required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: name,
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Display name',
      ),
    );
  }
}
