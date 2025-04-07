import 'package:flutter/material.dart';

class OverlayGradientWidget extends StatelessWidget {
  const OverlayGradientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xff224982).withOpacity(0.5),
            const Color(0xff224982),
          ],
        ),
      ),
    );
  }
}
