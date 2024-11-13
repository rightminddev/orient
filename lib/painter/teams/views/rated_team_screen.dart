import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/painter/teams/view_models/teams.viewmodel.dart';
import 'package:orient/painter/teams/views/loading/rated_team_loading.dart';
import 'package:orient/painter/teams/views/widgets/custom_rated_team_section.dart';
import 'package:orient/painter/teams/views/widgets/custom_teams_appbar.dart';
import 'package:orient/painter/teams/views/widgets/rated_teams_list_view_item.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class RatedTeamScreen extends StatefulWidget {
  const RatedTeamScreen({super.key});

  @override
  State<RatedTeamScreen> createState() => _RatedTeamScreenState();
}

class _RatedTeamScreenState extends State<RatedTeamScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_)=> TeamsViewModel()..initializeTopRated(context),
      child: Consumer<TeamsViewModel>(
        builder: (context, teamsViewModel, child) {
          return Scaffold(
            body:(teamsViewModel.isLoading)?
            const RatedTeamLoading()
            :CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: height * 0.35, // 250,
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
                              height: 313,
                              padding: const EdgeInsets.only(
                                right: AppSizes.s15,
                                left: AppSizes.s15,
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
                                    isShare: true,
                                    popFun: () {
                                      Navigator.pop(context);
                                    },
                                    title:
                                    AppStrings.ratedTeam.tr().toUpperCase(),
                                  ),
                                  gapH20,
                                   Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(top: 60),
                                          child: CustomRatedTeamSection(
                                              teamImage: AppImages.user,
                                              ratedImage: AppImages.sliver,
                                              teamName: "${teamsViewModel.topRatedTeamsModel.teams![1].name}",
                                              ratedImageHeight: AppSizes.s40,
                                              ratedImageWidth: AppSizes.s36,
                                              teamImageRaduis: 37,
                                              points: "${teamsViewModel.topRatedTeamsModel.teams![1].points}"),
                                        ),
                                        CustomRatedTeamSection(
                                            teamImage: AppImages.user,
                                            ratedImage: AppImages.gold,
                                            teamName: "${teamsViewModel.topRatedTeamsModel.teams![0].name}",
                                            ratedImageHeight: AppSizes.s44,
                                            ratedImageWidth: AppSizes.s46,
                                            teamImageRaduis: 42,
                                            points: "${teamsViewModel.topRatedTeamsModel.teams![0].points}"),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 60),
                                          child: CustomRatedTeamSection(
                                              teamImage: AppImages.user,
                                              ratedImage: AppImages.bronz,
                                              teamName: "${teamsViewModel.topRatedTeamsModel.teams![2].name}",
                                              ratedImageHeight: AppSizes.s32,
                                              ratedImageWidth: AppSizes.s32,
                                              teamImageRaduis: 33,
                                              points: "${teamsViewModel.topRatedTeamsModel.teams![2].points}"),
                                        ),
                                      ],
                                    ),
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
                      top: AppSizes.s20,),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return RatedTeamsListViewItem(index: index, teams: teamsViewModel.topRatedTeamsModel.teams,);
                      },
                      childCount: teamsViewModel.topRatedTeamsModel.teams!.length ,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar:(teamsViewModel.isLoading)?
            RatedTeamBottomBarLoading()
            :Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  defaultMinImageAppbar(containerHeight: 113),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Text(
                              "${teamsViewModel.topRatedTeamsModel.teams!.length}",
                              style: const TextStyle(
                                fontSize: AppSizes.s14,
                                fontWeight: FontWeight.w500,
                                color: Color(AppColors.textC5),
                              ),
                            ),
                            gapW16,
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: CachedNetworkImage(
                                  imageUrl: (teamsViewModel.topRatedTeamsModel.teams!.last!.image != null &&
                                      teamsViewModel.topRatedTeamsModel.teams!.last!.image!.isNotEmpty)
                                      ? teamsViewModel.topRatedTeamsModel.teams!.last!.image![0]!.file ?? ""
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
                            gapW16,
                            Text(
                              "${teamsViewModel.topRatedTeamsModel.teams!.last.name}".toUpperCase(),
                              style: const TextStyle(
                                fontSize: AppSizes.s13,
                                fontWeight: FontWeight.w500,
                                color: Color(AppColors.textC5),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${teamsViewModel.topRatedTeamsModel.teams!.last.points}".toUpperCase(),
                          style: const TextStyle(
                            fontSize: AppSizes.s17,
                            fontWeight: FontWeight.w700,
                            color: Color(AppColors.textC5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
