import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:shimmer/shimmer.dart';
class SingleProductScreenLoading extends StatelessWidget {
  const SingleProductScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 270,
                width: double.infinity,
                child: ShimmerAnimatedLoading(
                  circularRaduis: AppSizes.s50, // Adjust as needed
                ),
              ),
              const SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const ShimmerAnimatedLoading(
                    circularRaduis: AppSizes.s50,
                  ),
                  const SizedBox(height: 16),
                  const ShimmerAnimatedLoading(),
                  const SizedBox(height: 8),
                  const ShimmerAnimatedLoading(),
                  const SizedBox(height: 16),
                  const ShimmerAnimatedLoading(),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const ShimmerAnimatedLoading();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Row(
                      children: List.generate(3, (index) =>
                          Container(
                            width: 50,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                      height: 45.0,
                      width:  MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        color:  Colors.grey[300]!,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Replace the button with ShimmerAnimatedLoading for each item
                          return Container(
                            height: 32,
                            width: (MediaQuery.sizeOf(context).width * 0.9 /3) - 8,
                            alignment: Alignment.center,
                            child: const ShimmerAnimatedLoading(
                              circularRaduis: 50,
                            ),
                          );
                        },
                        itemCount: 3,
                      ),
                    ),
                  )
                ],
              ),
              ),
            ],
          ),
        ),
      ),
          bottomNavigationBar: Container(
            height: 136,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.1),
                  blurRadius: 11,
                  spreadRadius: 0,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Replace the actual UI with the Shimmer effect
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 26,
                      child: ShimmerAnimatedLoading(
                        circularRaduis: 5,
                      ),
                    ),
                    ShimmerAnimatedLoading(
                      circularRaduis: 5,
                    ),
                  ],
                ),
                ShimmerAnimatedLoading(
                  circularRaduis: 5,
                ),
              ],
            ),
          ),
    ));
  }
}
