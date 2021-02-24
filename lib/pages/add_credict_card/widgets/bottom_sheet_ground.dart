import 'package:flutter/material.dart';

class BottomSheetGround extends StatelessWidget {
  final Widget child;

  const BottomSheetGround({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.6;
    return Container(
      height: height,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            height: 10,
            width: size.width * 0.12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                color: Colors.white,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
