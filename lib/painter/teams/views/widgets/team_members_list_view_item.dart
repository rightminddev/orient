import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/models/people/member_model.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
class TeamMembersListViewItem extends StatelessWidget {
  final bool isAdd;
  List<MemberModel>? member ;
  int index;
  TeamMembersListViewItem({super.key, this.isAdd = false, required this.member, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s5,
            vertical: AppSizes.s14),
        decoration: BoxDecoration(
          color: const Color(AppColors.textC5),
          borderRadius: BorderRadius.circular(AppSizes.s10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.43,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)
                    ),
                    child: CachedNetworkImage(
                        imageUrl: (member![index].avatar != null)? member![index].avatar ?? "" : "",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.28,
                        child: Text(
                          "${member![index].name}".toUpperCase(),
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: AppSizes.s13,
                              fontWeight: FontWeight.w500,
                              color: Color(AppColors.black1Color)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.28,
                        child: Text(
                          "${member![index].phone}",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: AppSizes.s12,
                              fontWeight: FontWeight.w500,
                              color: const Color(AppColors.black1Color).withOpacity(0.5)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.s20, vertical: 9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s5),
                        color: const Color(AppColors.red1Color),
                      ),
                      child: Text(
                        "remove".toUpperCase(),
                        style: const TextStyle(
                            fontSize: AppSizes.s8,
                            fontWeight: FontWeight.w500,
                            color: Color(AppColors.textC5)),
                      ),
                    ),
                  ),
                  isAdd ? gapW8 : const SizedBox(),
                  isAdd
                      ? InkWell(
                          onTap: () {
                            defaultActionBottomSheet(
                                  context: context,
                                  title: "add user".toLowerCase(),
                                  headerIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      AppImages.info,
                                      width: 32,
                                      height: 32,
                                      color: const Color(AppColors.bgC3),
                                    ),
                                  ),
                                  subTitle:
                                      "Are you sure you added this user?"
                                          .toLowerCase(),
                                  buttonText: "Add Or Delete");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.s20, vertical: 9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSizes.s5),
                              color: const Color(AppColors.oC1Color),
                            ),
                            child: Text(
                              "add".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: AppSizes.s8,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppColors.textC5)),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ));
  }
}