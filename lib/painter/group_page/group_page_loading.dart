import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class GroupsPageLoading extends StatelessWidget {
  const GroupsPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              const SizedBox(height: 50),
              // Header shimmer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 24, height: 24, color: Colors.grey), // Back icon placeholder
                  Container(width: 100, height: 20, color: Colors.grey), // Title placeholder
                  Container(width: 24, height: 24, color: Colors.transparent), // Invisible icon
                ],
              ),
              const SizedBox(height: 20),
              // Content shimmer
              SizedBox(
                height: 80,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // Circular shimmer for profile picture
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Shimmer placeholders for text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(width: 100, height: 12, color: Colors.grey), // Title placeholder
                                const SizedBox(height: 5),
                                Container(width: 80, height: 10, color: Colors.grey), // Post count placeholder
                              ],
                            ),
                            const Spacer(),
                            // Shimmer placeholder for "Discover" button
                            Container(
                              width: 100,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
