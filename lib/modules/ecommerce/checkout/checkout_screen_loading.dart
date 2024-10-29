import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutScreenLoading extends StatelessWidget {
  const CheckoutScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body:Container(
          height: MediaQuery.sizeOf(context).height * 1,
          child: GradientBgImage(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Row(
                        children: [
                          // Shimmer effect for SVG icon placeholder
                          Container(
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          // Shimmer effect for text placeholder
                          Container(
                            width: 100, // Adjust width as needed
                            height: 16, // Adjust height as needed
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 20, // Height of the text
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const ShimmerAnimatedLoading(
                      circularRaduis: 50,
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 20, // Height of the text
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
                      ),
                      child: Row(
                        children: [
                          ShimmerPlaceholder(height: 30, width: 30), // Shimmer effect for icon
                          const SizedBox(width: 10),
                          Expanded(
                            child: ShimmerPlaceholder(height: 12, width: double.infinity), // Shimmer effect for text
                          ),
                          TextButton(
                            onPressed: () {},
                            child: ShimmerPlaceholder(height: 12, width: 50), // Shimmer effect for button text
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 20, // Height of the text
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: List.generate(5, (index) => _buildShimmerItem()),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withOpacity(0.1),
                blurRadius: 11,
                spreadRadius: 0,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  height: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100, // Adjust the width as needed
                        height: 12,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 50, // Adjust the width as needed
                        height: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              // Repeat for other rows as needed
              Spacer(),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 18,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 50,
                        height: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
  Widget _buildShimmerItem() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerPlaceholder({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
}

