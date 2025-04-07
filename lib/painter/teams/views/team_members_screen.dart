import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/view_models/user_cont.dart';
import 'package:orient/modules/shared_more_screen/contactus/controller/controller.dart';
import 'package:orient/painter/teams/view_models/teams.actions.viewmodel.dart';
import 'package:orient/painter/teams/view_models/teams.viewmodel.dart';
import 'package:orient/painter/teams/views/loading/team_memmber_loading.dart';
import 'package:orient/painter/teams/views/widgets/custom_button_bottom_sheet.dart';
import 'package:orient/painter/teams/views/widgets/custom_teams_appbar.dart';
import 'package:orient/painter/teams/views/widgets/leave_team_bottomsheet.dart';
import 'package:orient/painter/teams/views/widgets/team_members_list_view_item.dart';
import 'package:orient/painter/teams/views/widgets/team_memeber_request_listview.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';
import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:share_plus/share_plus.dart';

class TeamMembersScreen extends StatefulWidget {
  var id;
  bool admin = false;
  String roles;
  TeamMembersScreen(
      {super.key, required this.id, required this.admin, required this.roles});

  @override
  State<TeamMembersScreen> createState() => _TeamMembersScreenState();
}

class _TeamMembersScreenState extends State<TeamMembersScreen> {
  var gCache;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TeamsViewModel()
              ..initializeTeamDetailsScreen(context, widget.id)),
        ChangeNotifierProvider(create: (_) => TeamsActionsViewModel()),
      ],
      child: Consumer<TeamsViewModel>(
        builder: (context, teamsViewModel, child) {
          return Consumer<TeamsActionsViewModel>(
            builder: (context, teamsActionsViewModel, child) {
              var s1Cache;
              final json1String = CacheHelper.getString("US1");
              if (json1String != "") {
                s1Cache = json.decode(json1String) as Map<String, dynamic>;// Convert String back to JSON
                print("S1 IS --> $s1Cache");
                print("PREVIEW IS --> ${s1Cache['name']}");
              }
              print("s1Cache['user_team'] --> ${s1Cache['user_team']}");
              if (teamsActionsViewModel.joinTeamSuccess == true) {
                print("SUCCESS");
                Navigator.pop(context);
                teamsActionsViewModel.joinTeamSuccess = false;
              }
              if (teamsActionsViewModel.leaveTeamSuccess == true) {
                print("SUCESS");

                Navigator.pop(context);
                teamsActionsViewModel.leaveTeamSuccess = false;
              }
              if (teamsActionsViewModel.isApproveSuccess == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  teamsViewModel.initializeTeamDetailsScreen(
                      context, widget.id);
                  teamsActionsViewModel.isApproveSuccess = false;
                });
              }
              if (teamsActionsViewModel.isRefusedSuccess == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  teamsViewModel.initializeTeamDetailsScreen(
                      context, widget.id);
                  teamsActionsViewModel.isRefusedSuccess = false;
                });
              }
              return Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  final jsonString = CacheHelper.getString("USG");
                  if (jsonString != null) {
                    gCache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
                    print("S2 IS --> $gCache");
                  }
                  if(teamsActionsViewModel.joinTeamSuccess == true){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      value.initializeHomeScreen(context);
                    });
                    teamsActionsViewModel.joinTeamSuccess = false ;
                  }
                  return Scaffold(
                    backgroundColor: const Color(0xffFFFFFF),
                    body: (teamsViewModel.teamDetails != null &&
                        !teamsViewModel.isLoading )
                        ? GradientBgImage(
                      padding: EdgeInsets.zero,
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            expandedHeight: height * 0.26, //250,
                            pinned: true,
                            backgroundColor: Colors.transparent,
                            flexibleSpace: LayoutBuilder(builder:
                                (BuildContext context,
                                BoxConstraints constraints) {
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
                                          borderRadius:
                                          BorderRadius.only(
                                              bottomLeft: Radius
                                                  .circular(30),
                                              bottomRight:
                                              Radius.circular(
                                                  30)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              AppImages
                                                  .teamMemberBackGround,
                                            ),
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          gapH64,
                                          CustomTeamsAppbar(
                                            popFun: () {
                                              Navigator.of(context)
                                                  .pop();
                                            },
                                            shareFun: () async {
                                              await Share.share('''
                                                        ${AppStrings.joinMyTeamOnTheOrientApp.tr()}
                                                        ${AppStrings.downloadFromPlayStore.tr()}: ${gCache['store_url']['play_store']}
                                                        ${AppStrings.downloadFromAppleStore.tr()}: ${gCache['store_url']['app_store']}
                                                        ''', subject: 'انضم الي فريقي علي تطبيق اورينت');
                                            },
                                            isShare: true,
                                            title: AppStrings
                                                .teamMember
                                                .tr()
                                                .toUpperCase(),
                                          ),
                                          gapH36,
                                          Align(
                                            alignment:
                                            AlignmentDirectional
                                                .topStart,
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      86),
                                                  child:
                                                  CachedNetworkImage(
                                                    height: 86,
                                                    width: 86,
                                                    fit: BoxFit.cover,
                                                    imageUrl: (teamsViewModel
                                                        .teamDetails!
                                                        .team!.image![0].file !=
                                                        null &&
                                                        teamsViewModel
                                                            .teamDetails!
                                                            .team!.image!
                                                            .isNotEmpty)
                                                        ? teamsViewModel
                                                        .teamDetails!
                                                        .team!.image![0].file ??
                                                        ""
                                                        : "",
                                                    placeholder: (context,
                                                        url) =>
                                                    const ShimmerAnimatedLoading(),
                                                    errorWidget: (context,
                                                        url,
                                                        error) =>
                                                    const Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      size: AppSizes
                                                          .s32,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                ),
                                                gapW16,
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.5,
                                                      child: Text(
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        "${teamsViewModel.teamDetails!.team!.name}"
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            fontSize:
                                                            AppSizes
                                                                .s20,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Color(
                                                                AppColors
                                                                    .textC5)),
                                                      ),
                                                    ),
                                                    gapH6,
                                                    SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.5,
                                                      child: Text(
                                                        "${teamsViewModel.teamDetails!.team!.owner!.name}"
                                                            .toUpperCase(),
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize:
                                                            AppSizes
                                                                .s14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400,
                                                            color: Color(
                                                                AppColors
                                                                    .textC5)),
                                                      ),
                                                    ),
                                                    gapH6,
                                                    Text(
                                                      "${teamsViewModel.teamDetails!.team!.totalPoints} ${AppStrings.points.tr().toUpperCase()}"
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize:
                                                          AppSizes
                                                              .s12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color: Color(
                                                              AppColors
                                                                  .textC5)),
                                                    ),
                                                  ],
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
                            }),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.s24),
                            sliver: SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  gapH20,
                                  Text(
                                    AppStrings.teams
                                        .tr()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: AppSizes.s14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(
                                            AppColors.oC2Color)),
                                  ),
                                  gapH6,
                                  Container(
                                    height: (teamsViewModel
                                        .teamDetails!
                                        .team!.members!
                                        .length ==
                                        1)
                                        ? 100
                                        : (teamsViewModel
                                        .teamDetails!
                                        .team!.members!
                                        .length ==
                                        2)
                                        ? 200
                                        : 300,
                                    alignment: (teamsViewModel
                                        .teamDetails!
                                        .team!.members!
                                        .isNotEmpty)
                                        ? Alignment.topCenter
                                        : Alignment.center,
                                    child: (teamsViewModel
                                        .teamDetails!
                                        .team!.members!
                                        .isNotEmpty)
                                        ? ListView.builder(
                                      itemCount: teamsViewModel
                                          .teamDetails!
                                          .team!.members!
                                          .length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                      const ClampingScrollPhysics(),
                                      itemBuilder:
                                          (context, index) {
                                        return TeamMembersListViewItem(
                                          member: teamsViewModel
                                              .teamDetails!
                                              .team!.members,
                                          teamId: widget.id,
                                          index: index,
                                          owner: (UserSettingConst
                                              .userSettings!
                                              .userId ==
                                              teamsViewModel
                                                  .teamDetails!
                                                  .team!.owner!
                                                  .id)
                                              ? true
                                              : false,
                                        );
                                      },
                                    )
                                        : Center(
                                      child: Text(
                                        AppStrings.noMemberFound
                                            .tr()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize:
                                            AppSizes.s14,
                                            fontWeight:
                                            FontWeight.w500,
                                            color: Color(
                                                AppColors
                                                    .oC2Color)),
                                      ),
                                    ),
                                  ),
                                  gapH18,
                                  if (s1Cache['user_id'] ==
                                      teamsViewModel
                                          .teamDetails!.team!.owner!.id)
                                    Text(
                                      AppStrings
                                          .membersWhoWouldLikeToJoinYourTeam
                                          .tr()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: AppSizes.s13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(
                                              AppColors.oC2Color)),
                                    ),
                                  gapH12,
                                  if (s1Cache['user_id'] ==
                                      teamsViewModel
                                          .teamDetails!.team!.owner!.id)
                                    Container(
                                      color: Colors.transparent,
                                      height: (teamsViewModel
                                          .teamDetails!
                                          .team!.members!
                                          .length ==
                                          1)
                                          ? 100
                                          : (teamsViewModel
                                          .teamDetails!
                                          .team
                                          !.members!
                                          .length ==
                                          2)
                                          ? 200
                                          : 250,
                                      alignment: (teamsViewModel
                                          .teamDetails!.team!
                                          .members!
                                          .isNotEmpty)
                                          ? Alignment.topCenter
                                          : Alignment.center,
                                      child: (teamsViewModel
                                          .teamDetails!
                                          .team!.members!
                                          .isNotEmpty)
                                          ? ListView.builder(
                                        itemCount:
                                        teamsViewModel
                                            .requestMembers
                                            .length,
                                        shrinkWrap: true,
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            bottom: AppSizes
                                                .s8),
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (context, index) {
                                          return TeamMembersRequestListViewItem(
                                              teamId: widget.id,
                                              isAdd: true,
                                              member:
                                              teamsViewModel
                                                  .teamDetails!
                                                  .team!.members,
                                              index: index);
                                        },
                                      )
                                          : Center(
                                        child: Text(
                                          AppStrings
                                              .noMemberFound
                                              .tr()
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize:
                                              AppSizes.s14,
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                              color: Color(
                                                  AppColors
                                                      .oC2Color)),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : TeamMemmberLoading(),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        color: const Color(AppColors.bgC3),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(40.0)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffC9CFD2)
                                .withOpacity(0.5),
                            blurRadius: AppSizes.s5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppSizes.s36,
                            bottom: AppSizes.s36,
                            right: AppSizes.s24,
                            left: AppSizes.s24),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            if (teamsViewModel.teamDetails != null &&
                                s1Cache['user_id'] != teamsViewModel.teamDetails!.team!.owner!.id  &&
                                !teamsViewModel.teamDetails!.team!.members!.contains("${s1Cache['user_id']}") && s1Cache['user_team'] != null&&s1Cache['user_team']['id'] != teamsViewModel.teamDetails!.team!.id)
                              CustomButtonBottomSheet(
                                  image: AppImages.userJoin,
                                  title: AppStrings.joinTeam
                                      .tr()
                                      .toUpperCase(),
                                  backGroundColor: AppColors.oC1Color,
                                  function: () async{
                                   await defaultActionBottomSheet(
                                        context: context,
                                       home: false,
                                        title: AppStrings.joinTeam
                                            .tr()
                                            .toLowerCase(),
                                        view: teamsActionsViewModel
                                            .isLoading,
                                        onTapButton: () {
                                          teamsActionsViewModel
                                              .joinTeam(
                                              context, widget.id);
                                        },
                                        headerIcon: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              8.0),
                                          child: SvgPicture.asset(
                                            "assets/images/svg/join.svg",
                                            width: 32,
                                            height: 32,
                                          ),
                                        ),
                                        subTitle: AppStrings
                                            .byJoinToTeamYouAgreeToTheTermsAndConditions
                                            .tr()
                                            .toLowerCase(),
                                        buttonText: AppStrings.join.tr());
                                   teamsViewModel.initializeTeamDetailsScreen(context, widget.id);
                                  }),
                             if(s1Cache['user_team'] == null) CustomButtonBottomSheet(
                                  image: AppImages.userJoin,
                                  title: AppStrings.joinTeam
                                      .tr()
                                      .toUpperCase(),
                                  backGroundColor: AppColors.oC1Color,
                                  function: () async{
                                   await defaultActionBottomSheet(
                                        context: context,
                                       home: false,
                                        title: AppStrings.joinTeam
                                            .tr()
                                            .toLowerCase(),
                                        view: teamsActionsViewModel
                                            .isLoading,
                                        onTapButton: () {
                                          teamsActionsViewModel
                                              .joinTeam(
                                              context, widget.id);
                                        },
                                        headerIcon: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              8.0),
                                          child: SvgPicture.asset(
                                            "assets/images/svg/join.svg",
                                            width: 32,
                                            height: 32,
                                          ),
                                        ),
                                        subTitle: AppStrings
                                            .byJoinToTeamYouAgreeToTheTermsAndConditions
                                            .tr()
                                            .toLowerCase(),
                                        buttonText: AppStrings.join.tr());
                                   teamsViewModel.initializeTeamDetailsScreen(context, widget.id);
                                  }),
                            gapW10,
                            if (s1Cache['user_team'] != null && teamsViewModel.teamDetails != null )
                              if(teamsViewModel.teamDetails!.team!.members!.contains("${s1Cache['user_id']}") || s1Cache['user_team']['id'] == teamsViewModel.teamDetails!.team!.id)
                              CustomButtonBottomSheet(
                                  image: AppImages.signOut,
                                  title: AppStrings.leaveTeam
                                      .tr()
                                      .toUpperCase(),
                                  backGroundColor:
                                  AppColors.red1Color,
                                  function: () async {
                                    await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true, // Allow full screen interaction
                                        builder: (BuildContext context) {
                                          return LeaveTeamBottomsheet(
                                              members: teamsViewModel.teamDetails!.team!.members,
                                              id: widget.id,
                                            viewDrop:s1Cache['user_team']['id'] == teamsViewModel.teamDetails!.team!.id ? true : false
                                          );
                                        }
                                    );
                                   teamsViewModel.initializeTeamDetailsScreen(context, widget.id);
                                  }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
