import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:shimmer/shimmer.dart';

class CartScreenLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: Container(
          height: MediaQuery.sizeOf(context).height * 1,
          child: GradientBgImage(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 136,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.1),
                              blurRadius: 11,
                              spreadRadius: 0,
                              offset: const Offset(0, -4)),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ShimmerAnimatedLoading(height: 14, width: 100), // Total Price Shimmer
                                const SizedBox(height: 4),
                                const ShimmerAnimatedLoading(height: 20, width: 80), // Price shimmer
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color:  Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minHeight: 0,
                              maxHeight: 400,
                            ),
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffFFFFFF),
                            ),
                            child:  ListView.builder(
                              shrinkWrap: true,
                              reverse: false,
                              physics: const ClampingScrollPhysics(),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ShimmerAnimatedLoading(
                                      circularRaduis: 15,
                                      width: 90,
                                      height: 99,
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ShimmerAnimatedLoading(
                                            width: double.infinity,
                                            height: 15,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              ShimmerAnimatedLoading(
                                                width: 70,
                                                height: 15,
                                              ),
                                              SizedBox(width: 10),
                                              ShimmerAnimatedLoading(
                                                width: 50,
                                                height: 12,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ShimmerAnimatedLoading(
                                                width: 30,
                                                height: 20,
                                              ),
                                              ShimmerAnimatedLoading(
                                                width: 30,
                                                height: 20,
                                              ),
                                              ShimmerAnimatedLoading(
                                                width: 30,
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ShimmerAnimatedLoading(
                                      circularRaduis: 20, // Icon shimmer radius
                                      width: 30, // Icon placeholder width
                                      height: 30, // Icon placeholder height
                                    ),
                                  ],
                                );
                              },
                            )
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ShimmerAnimatedLoading(
                                  width: 100, // Subtotal label width
                                  height: 20, // Subtotal label height
                                ),
                                ShimmerAnimatedLoading(
                                  width: 60, // Subtotal value width
                                  height: 20, // Subtotal value height
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 51,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20,
                            width: 100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade300,
                            Colors.grey.shade100,
                            Colors.grey.shade300,
                          ],
                          begin: Alignment(-1, 0),
                          end: Alignment(1, 0),
                          stops: const [0.2, 0.5, 0.8],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // Add a shimmer animation using a TweenAnimationBuilder
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: -1, end: 1),
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(value * MediaQuery.of(context).size.width, 0),
                            child: child,
                          );
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    )
                  ],
                ),
              ),
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
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 26,
                    child:_buildShimmerEffect(width: 100, height: 20)
                  ),
               _buildShimmerEffect(width: 80, height: 30)
                ],
              ),
               _buildShimmerEffect(width: 120, height: 36)
            ],
          ),
        )
    );
  }
  Widget _buildShimmerEffect({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
