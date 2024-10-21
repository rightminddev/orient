import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/teams/views/widgets/custom_rated_team_section.dart';
import 'package:orient/modules/teams/views/widgets/custom_teams_appbar.dart';
import 'package:orient/modules/teams/views/widgets/rated_teams_list_view_item.dart';

class RatedTeamScreen extends StatelessWidget {
  const RatedTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: height * 0.45, // 250,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        FlexibleSpaceBar(
                          background: Container(
                            padding: const EdgeInsets.only(
                              right: AppSizes.s24,
                              left: AppSizes.s24,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage(AppImages.teamMemberBackGround),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                gapH64,
                                CustomTeamsAppbar(
                                  isShare: false,
                                  popFun: () {},
                                  title: "Rated Team".toUpperCase(),
                                ),
                                gapH10,
                                Column(
                                  children: [
                                    CustomRatedTeamSection(
                                        teamImage: AppImages.user,
                                        ratedImage: AppImages.gold,
                                        teamName: "al-HamadEgypt",
                                        ratedImageHeight: AppSizes.s44,
                                        ratedImageWidth: AppSizes.s46,
                                        teamImageRaduis: 42,
                                        points: "15505"),
                                        gapH14,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomRatedTeamSection(
                                            teamImage: AppImages.user,
                                            ratedImage: AppImages.gold,
                                            teamName: "al-HamadEgypt",
                                            ratedImageHeight: AppSizes.s40,
                                            ratedImageWidth: AppSizes.s36,
                                            teamImageRaduis: 37,
                                            points: "14005"),
                                            CustomRatedTeamSection(
                                                teamImage: AppImages.user,
                                                ratedImage: AppImages.gold,
                                                teamName: "al-HamadEgypt",
                                                ratedImageHeight: AppSizes.s32,
                                                ratedImageWidth: AppSizes.s32,
                                                teamImageRaduis: 33,
                                                points: "13000"),
                                      ],
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(
                    top: AppSizes.s20, bottom: AppSizes.s125),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return RatedTeamsListViewItem(index: index);
                    },
                    childCount: 9,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                top: AppSizes.s28,
                bottom: AppSizes.s50,
                start: AppSizes.s32,
                end: AppSizes.s32,
              ),
              decoration: const BoxDecoration(
                color: Color(AppColors.oC1Color),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(30),
                  topStart: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "30",
                        style: TextStyle(
                          fontSize: AppSizes.s14,
                          fontWeight: FontWeight.w500,
                          color: Color(AppColors.textC5),
                        ),
                      ),
                      gapW16,
                      const CircleAvatar(
                        radius: AppSizes.s20,
                        backgroundImage:
                            AssetImage(AppImages.circleNotification),
                      ),
                      gapW16,
                      Text(
                        "best first paints".toUpperCase(),
                        style: const TextStyle(
                          fontSize: AppSizes.s13,
                          fontWeight: FontWeight.w500,
                          color: Color(AppColors.textC5),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "12500".toUpperCase(),
                    style: const TextStyle(
                      fontSize: AppSizes.s17,
                      fontWeight: FontWeight.w700,
                      color: Color(AppColors.textC5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
