import 'package:flutter/material.dart';

class BottomSheetEdge extends StatelessWidget {
  const BottomSheetEdge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
    );
  }
}
