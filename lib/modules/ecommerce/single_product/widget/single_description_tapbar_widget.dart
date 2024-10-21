import 'package:flutter/material.dart';

class SingleDescriptionTapbarWidget extends StatelessWidget {
  const SingleDescriptionTapbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Super Seal 123 is a highly developed product that absorbs deeply into the substrate...",
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
