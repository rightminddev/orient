import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TeamScreenLoading extends StatelessWidget {
  const TeamScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
          reverse: false,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Circular shimmer for profile image
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    // Rectangular shimmer for team name
                    Container(
                      width: 100.0,
                      height: 14.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                // Shimmer for button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey,
                  ),
                  child: Container(
                    width: 40.0,
                    height: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 20,),
          itemCount: 5
      ),
    );
  }
}
