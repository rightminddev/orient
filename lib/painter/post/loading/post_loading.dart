import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostLoading extends StatelessWidget {
  const PostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Shimmer box representing SliverAppBar content
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          // Shimmer list items
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Circle for profile image
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Line for username
                        Container(
                          width: 100,
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Box for post content
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    // Box for media preview
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
