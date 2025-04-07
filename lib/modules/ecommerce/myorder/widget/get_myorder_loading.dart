import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GetMyorderLoading extends StatelessWidget {
  const GetMyorderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          height: 140, // Adjust based on your original UI height
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemCount: 5,
      ),
    );
  }
}
