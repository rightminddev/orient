import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeamMemmberLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              height: 20,
              width: 150,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Container(
              height: 20,
              width: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
