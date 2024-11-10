import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeamMemmberLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          // Shimmer for a title or small text
          Container(
            height: 20,
            width: 150,
            color: Colors.grey,
          ),
          SizedBox(height: 10),

          // Shimmer for a circular profile image
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 10),

          // Shimmer for a longer text or content area
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(height: 10),

          // Shimmer for smaller text or other sections
          Container(
            height: 20,
            width: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 10),

          // Shimmer for a full-width container
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
