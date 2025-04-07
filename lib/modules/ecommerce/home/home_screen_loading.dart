import 'package:flutter/material.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:orient/constants/app_sizes.dart';

class HomeScreenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                  child: ShimmerAnimatedLoading(
                    height: 360,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: ShimmerAnimatedLoading(
                                height: 50,
                                width: 50,
                                circularRaduis: AppSizes.s50,
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ShimmerAnimatedLoading(
                                    height: 24,
                                    width: 24,
                                    circularRaduis: AppSizes.s24,
                                  ),
                                  ShimmerAnimatedLoading(
                                    height: 24,
                                    width: 24,
                                    circularRaduis: AppSizes.s24,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      const ShimmerAnimatedLoading(
                        height: 50,
                        width: 200,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height: 115,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const ShimmerAnimatedLoading(
                              height: 100,
                              width: 100,
                              circularRaduis: AppSizes.s50,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemCount:
                                5, // Example count for shimmer placeholders
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            const SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerAnimatedLoading(
                      width: 150,
                      height: 20,
                      circularRaduis: AppSizes.s5,
                    ),
                    ShimmerAnimatedLoading(
                      width: 50,
                      height: 20,
                      circularRaduis: AppSizes.s5,
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            SizedBox(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Number of shimmer placeholders
                  itemBuilder: (context, index) {
                    return const ShimmerAnimatedLoading(
                      width: 150,
                      height: 220,
                      circularRaduis: AppSizes.s10,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              height: 115,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(115),
                      child: ShimmerAnimatedLoading(
                        width: 115,
                        height: 115,
                        circularRaduis: 10, // Adjust radius as needed
                      ),
                    ),
                    Container(
                      width: 115,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ShimmerAnimatedLoading(
                        width: 100,
                        height: 20,
                        circularRaduis: 5, // Adjust radius as needed
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 0),
                itemCount: 3, // Number of shimmer placeholders
              )),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            reverse: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Column(
              children: [
                const SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerAnimatedLoading(
                        height: 15,
                        width: 100,
                        circularRaduis: 5,
                      ),
                      Row(
                        children: [
                          ShimmerAnimatedLoading(
                            height: 10,
                            width: 40,
                            circularRaduis: 5,
                          ),
                          SizedBox(width: 10),
                          ShimmerAnimatedLoading(
                            height: 10,
                            width: 10,
                            circularRaduis: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      reverse: false,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, indexs) => Container(
                        width: 160, // Adjust width based on your design
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300, // Placeholder color
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Column(
                          children: [
                            ShimmerAnimatedLoading(
                              height: 120,
                              width: double.infinity,
                              circularRaduis: 8,
                            ),
                            SizedBox(height: 8),
                            ShimmerAnimatedLoading(
                              height: 15,
                              width: 80,
                              circularRaduis: 5,
                            ),
                            SizedBox(height: 5),
                            ShimmerAnimatedLoading(
                              height: 10,
                              width: 50,
                              circularRaduis: 5,
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemCount: 4,
                    ),
                  ),
                )
              ],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: 3,
          ),
        )
      ],
    );
  }
}
