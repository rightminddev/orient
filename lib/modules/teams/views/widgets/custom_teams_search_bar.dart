import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/teams/views/rated_team_screen.dart';

class CustomTeamsSearchBar extends StatelessWidget {
  const CustomTeamsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: const Color(AppColors.textC5),
            borderRadius: BorderRadius.circular(AppSizes.s10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.s10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search'.toUpperCase(),
                  hintStyle: const TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w400,
                      color: Color(AppColors.grey1Color)),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(AppSizes.s10),
                    child: SvgPicture.asset(
                      AppImages.search,
                      width: AppSizes.s24,
                      height: AppSizes.s24,
                    ),
                  )),
            ),
          ),
        )),
        gapW14,
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const RatedTeamScreen();
              },
            ));
          },
          child: Container(
              alignment: Alignment.center,
              width: AppSizes.s40,
              height: AppSizes.s40,
              decoration: BoxDecoration(
                  color: const Color(AppColors.oC2Color),
                  borderRadius: BorderRadius.circular(AppSizes.s10)),
              child: SvgPicture.asset(
                AppImages.badge,
                width: AppSizes.s24,
                height: AppSizes.s24,
              )),
        ),
      ],
    );
  }
}
