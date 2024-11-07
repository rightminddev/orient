import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/teams/views/rated_team_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:provider/provider.dart';

import '../../view_models/teams.viewmodel.dart';

class CustomTeamsSearchBar extends StatefulWidget {
  CustomTeamsSearchBar({super.key});

  @override
  State<CustomTeamsSearchBar> createState() => _CustomTeamsSearchBarState();
}

class _CustomTeamsSearchBarState extends State<CustomTeamsSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TeamsViewModel>(
      builder: (context, value, child) {
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
                      controller: _searchController,
                      onChanged: (String? values){
                        value.initializeTeamList(context, "teams", name: values);
                      },
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
                context.pushNamed(AppRoutes.painterRatedTeamsScreen.name,
                    pathParameters: {'lang': context.locale.languageCode});
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
      },
    );
  }
}
