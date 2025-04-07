import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationDetailsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.225,
            color: Colors.grey,
          ),
          const SizedBox(height: 24),
          Container(
            height: 12,
            width: 150,
            color: Colors.grey,
          ),
          const SizedBox(height: 14),
          Container(
            height: 16,
            width: double.infinity,
            color: Colors.grey,
          ),
          const SizedBox(height: 14),
          Container(
            height: 12,
            width: double.infinity,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Container(
            height: 12,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
