import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
class TeamMembersListViewItem extends StatelessWidget {
  final bool isAdd;

  const TeamMembersListViewItem({super.key, this.isAdd = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s16, vertical: AppSizes.s14),
        decoration: BoxDecoration(
          color: const Color(AppColors.textC5),
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
                const CircleAvatar(
                  radius: AppSizes.s22,
                  backgroundImage: AssetImage(AppImages.circleNotification),
                ),
                gapW10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ahmed Ali".toUpperCase(),
                      style: const TextStyle(
                          fontSize: AppSizes.s13,
                          fontWeight: FontWeight.w500,
                          color: Color(AppColors.black1Color)),
                    ),
                    const Text(
                      "+20 1299857520",
                      style: TextStyle(
                          fontSize: AppSizes.s12,
                          fontWeight: FontWeight.w500,
                          color: Color(AppColors.grey1Color)),
                    ),
                  ],
                )
              ],
            ),
            Row(
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
          ],
        ));
  }
}
