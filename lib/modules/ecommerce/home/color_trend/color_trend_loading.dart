import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:shimmer/shimmer.dart';

class ColorTrendLoading extends StatelessWidget {
  const ColorTrendLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBgImage(
      padding: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
             Container(
          height: 330,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  child: Container(
                    height: 360,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 360,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.transparent,
                  height: 90,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xffFFFFFF)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        AppStrings.colorTrend.tr().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
              const SizedBox(height: 20,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 24, // Matches the text's height
                      color: Colors.grey[300],
                    ),
                  )
                ),
              ),
              const SizedBox(height: 20,),
              MasonryGridView.builder(
                shrinkWrap: true,
                reverse: false,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                itemBuilder: (BuildContext context, int index) {
                  double containerHeight = (index % 2 == 0 ? 180 : 80);
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
