import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GetOrderDetailsLoading extends StatelessWidget {
  const GetOrderDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Row Shimmer
            Row(
              children: [
                Container(
                  height: 20,
                  width: 120,
                  color: Colors.white,
                ),
                const Spacer(),
                Container(
                  height: 20,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // List Items Shimmer
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 99,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: 20, width: double.infinity, color: Colors.white),
                            const SizedBox(height: 10),
                            Container(height: 15, width: 100, color: Colors.white),
                            const SizedBox(height: 5),
                            Container(height: 15, width: 50, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Order Information Shimmer
            Container(height: 20, width: 150, color: Colors.white),
            const SizedBox(height: 15),
            for (int i = 0; i < 5; i++) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(height: 15, width: 100, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(child: Container(height: 15, color: Colors.white)),
                ],
              ),
            ],

            const SizedBox(height: 25),

            // Button Shimmer
            Container(height: 40, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
