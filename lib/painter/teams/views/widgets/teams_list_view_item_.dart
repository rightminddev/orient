import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/models/teams/team_model.dart';
import 'package:orient/painter/teams/views/team_members_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class TeamsListViewItem extends StatelessWidget {
  final List<TeamModel> model;
  final int index;
  TeamsListViewItem({super.key, required this.model, required this.index});
  @override
  Widget build(BuildContext context) {
    final team = model[index];
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.painterMemberTeamsScreen.name,
            pathParameters: {'lang': context.locale.languageCode,
              'id' : "${team.id}"
            });
      },
      child: Container(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                        imageUrl: (team.image != null &&
                            team.image!.isNotEmpty)
                            ? team.image![0]!.file ?? ""
                            : "",
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
                  Text(
                    "${team.name}".toUpperCase(),
                    style: const TextStyle(
                        fontSize: AppSizes.s14,
                        fontWeight: FontWeight.w500,
                        color: Color(AppColors.black1Color)),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  context.pushNamed(AppRoutes.painterMemberTeamsScreen.name,
                      pathParameters: {'lang': context.locale.languageCode,
                        'id' : "${team.id}"
                      });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s20, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s5),
                    color: const Color(AppColors.oC2Color),
                  ),
                  child: Text(
                    "More".toUpperCase(),
                    style: const TextStyle(
                        fontSize: AppSizes.s8,
                        fontWeight: FontWeight.w500,
                        color: Color(AppColors.textC5)),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
