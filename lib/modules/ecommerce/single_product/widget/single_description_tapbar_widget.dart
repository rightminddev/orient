import 'package:flutter/material.dart';

class SingleDescriptionTapbarWidget extends StatelessWidget {
  const SingleDescriptionTapbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const Text(
        "Super Seal 123 is a highly developed product that absorbs deeply into the substrate...",
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
