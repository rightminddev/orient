import 'package:flutter/material.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class SearchScreenLoading extends StatelessWidget {
  const SearchScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: Colors.transparent,
              height: 90,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerAnimatedLoading(
                    circularRaduis: 20,
                    width: 32,
                    height: 32,
                  ),
                  ShimmerAnimatedLoading(
                    width: 100,
                    height: 20,
                  ),
                  ShimmerAnimatedLoading(
                    circularRaduis: 5,
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    const SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerAnimatedLoading(
                            height: 12,
                            width: 100, // Adjust width as needed
                          ),
                          Row(
                            children: [
                              ShimmerAnimatedLoading(
                                height: 8,
                                width: 50, // Adjust width as needed
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 240,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, indexs) => const ShimmerAnimatedLoading(
                            height: 240,
                            width: 150, // Adjust width as needed
                          ),
                          separatorBuilder: (context, index) => const SizedBox(width: 10),
                          itemCount: 5, // Placeholder count for shimmer
                        ),
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemCount: 3, // Placeholder count for shimmer
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                reverse: false,
                clipBehavior: Clip.none,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: .7,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return const ShimmerAnimatedLoading();
                },
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
