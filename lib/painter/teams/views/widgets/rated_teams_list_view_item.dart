  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
  import 'package:orient/constants/app_colors.dart';
  import 'package:orient/constants/app_images.dart';
  import 'package:orient/constants/app_sizes.dart';

  import '../../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

  class RatedTeamsListViewItem extends StatelessWidget {
    final int index;
    List? teams;
    RatedTeamsListViewItem({super.key, required this.index, required this.teams});
    @override
    Widget build(BuildContext context) {
      return (index != 0 && index != 1 && index != 2 && index != teams!.length - 1) ?Container(
        margin: const EdgeInsets.symmetric(
            vertical: AppSizes.s8, horizontal: AppSizes.s24),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s18,
          vertical: AppSizes.s12,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(AppSizes.s10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontSize: AppSizes.s14,
                    fontWeight: FontWeight.w500,
                    color: Color(AppColors.black1Color),
                  ),
                ),
                gapW12,
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                      imageUrl: (teams![index].image.isNotEmpty && teams![index].image != null)?(teams![index].image[0] != null)?teams![index].image[0].file : "":"",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      placeholder: (context,
                          url) =>
                      const ShimmerAnimatedLoading(
                        circularRaduis:
                        AppSizes.s50,
                      ),
                      errorWidget: (context,
                          url, error) =>
                      const Icon(
                        Icons
                            .image_not_supported_outlined,
                      )),
                ),
                gapW10,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  child: Text(
                    maxLines: 1,
                    teams![index].name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: AppSizes.s14,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.black1Color),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${teams![index].points}",
              style: const TextStyle(
                fontSize: AppSizes.s14,
                fontWeight: FontWeight.w500,
                color: Color(AppColors.oC2Color),
              ),
            ),
          ],
        ),
      ): const SizedBox(width: 0.00001,);
    }
  }
