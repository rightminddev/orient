import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/shared_more_screen/contactus/controller/controller.dart';
import 'package:orient/painter/teams/view_models/teams.actions.viewmodel.dart';
import 'package:orient/painter/teams/view_models/teams.viewmodel.dart';
import 'package:orient/painter/teams/views/loading/team_memmber_loading.dart';
import 'package:orient/painter/teams/views/widgets/custom_button_bottom_sheet.dart';
import 'package:orient/painter/teams/views/widgets/custom_teams_appbar.dart';
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
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TeamsViewModel()
              ..initializeTeamDetailsScreen(context, widget.id)),
        ChangeNotifierProvider(create: (_) => TeamsActionsViewModel()),
        ChangeNotifierProvider(
            create: (_) => ContactUsController()..getGeneral(context)),
      ],
      child: Consumer<TeamsViewModel>(
        builder: (context, teamsViewModel, child) {
          return Consumer<TeamsActionsViewModel>(
            builder: (context, teamsActionsViewModel, child) {
              if (teamsActionsViewModel.joinTeamSuccess == true) {
                print("SUCCESS");
                teamsViewModel.initializeTeamDetailsScreen(context, widget.id);
                teamsActionsViewModel.joinTeamSuccess = false;
              }
              if (teamsActionsViewModel.leaveTeamSuccess == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  teamsViewModel.initializeTeamDetailsScreen(
                      context, widget.id);
                  teamsActionsViewModel.leaveTeamSuccess = false;
                });
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
                  return Consumer<ContactUsController>(
                    builder: (context, contactUs, child) {
                      return Scaffold(
                        backgroundColor: const Color(0xffFFFFFF),
                        body: (teamsViewModel.teamDetails != null &&
                                !teamsViewModel.isLoading &&
                                !contactUs.isLoading)
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
                                                        ${AppStrings.downloadFromPlayStore.tr()}: ${contactUs.links['play_store']}
                                                        ${AppStrings.downloadFromAppleStore.tr()}: ${contactUs.links['app_store']}
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
                                                                              .image !=
                                                                          null &&
                                                                      teamsViewModel
                                                                          .teamDetails!
                                                                          .image!
                                                                          .isNotEmpty)
                                                                  ? teamsViewModel
                                                                          .teamDetails!
                                                                          .image![
                                                                              0]!
                                                                          .file ??
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
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
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
                                                                  "${teamsViewModel.teamDetails!.name}"
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
                                                                  "${teamsViewModel.teamDetails!.owner!.name}"
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
                                                                "${teamsViewModel.teamDetails!.totalPoints} ${AppStrings.points.tr().toUpperCase()}"
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
                                                          .members!
                                                          .length ==
                                                      1)
                                                  ? 100
                                                  : (teamsViewModel
                                                              .teamDetails!
                                                              .members!
                                                              .length ==
                                                          2)
                                                      ? 200
                                                      : 300,
                                              alignment: (teamsViewModel
                                                      .teamDetails!
                                                      .members!
                                                      .isNotEmpty)
                                                  ? Alignment.topCenter
                                                  : Alignment.center,
                                              child: (teamsViewModel
                                                      .teamDetails!
                                                      .members!
                                                      .isNotEmpty)
                                                  ? ListView.builder(
                                                      itemCount: teamsViewModel
                                                          .teamDetails!
                                                          .members!
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
                                                              .members,
                                                          teamId: widget.id,
                                                          index: index,
                                                          owner: (value
                                                                      .userSettings!
                                                                      .userId ==
                                                                  teamsViewModel
                                                                      .teamDetails!
                                                                      .owner!
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
                                            if (value.userSettings!.userId ==
                                                teamsViewModel
                                                    .teamDetails!.owner!.id)
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
                                            if (value.userSettings!.userId ==
                                                teamsViewModel
                                                    .teamDetails!.owner!.id)
                                              Container(
                                                color: Colors.transparent,
                                                height: (teamsViewModel
                                                            .teamDetails!
                                                            .members!
                                                            .length ==
                                                        1)
                                                    ? 100
                                                    : (teamsViewModel
                                                                .teamDetails!
                                                                .members!
                                                                .length ==
                                                            2)
                                                        ? 200
                                                        : 250,
                                                alignment: (teamsViewModel
                                                        .teamDetails!
                                                        .members!
                                                        .isNotEmpty)
                                                    ? Alignment.topCenter
                                                    : Alignment.center,
                                                child: (teamsViewModel
                                                        .teamDetails!
                                                        .members!
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
                                                                      .members,
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
                        bottomNavigationBar: (value.userSettings?.userTeam ==
                                    null &&
                                teamsViewModel.teamDetails != null)
                            ? Container(
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
                                      if (value.userSettings!.userId !=
                                          teamsViewModel.teamDetails!.owner!.id)
                                        CustomButtonBottomSheet(
                                            image: AppImages.userJoin,
                                            title: AppStrings.joinTeam
                                                .tr()
                                                .toUpperCase(),
                                            backGroundColor: AppColors.oC1Color,
                                            function: () {
                                              defaultActionBottomSheet(
                                                  context: context,
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
                                                  buttonText: "Join");
                                            }),
                                      gapW10,
                                      if (teamsViewModel
                                          .teamDetails!.members!.isNotEmpty)
                                        CustomButtonBottomSheet(
                                            image: AppImages.signOut,
                                            title: AppStrings.leaveTeam
                                                .tr()
                                                .toUpperCase(),
                                            backGroundColor:
                                                AppColors.red1Color,
                                            function: () {
                                              defaultActionBottomSheet(
                                                  context: context,
                                                  title: AppStrings.leaveTeam
                                                      .tr()
                                                      .toLowerCase(),
                                                  view: teamsActionsViewModel
                                                      .isLoading,
                                                  viewDropDownButton: (value
                                                              .userSettings!
                                                              .userId ==
                                                          teamsViewModel
                                                              .teamDetails!
                                                              .owner!
                                                              .id)
                                                      ? true
                                                      : false,
                                                  dropDownOnChanged:
                                                      (String? value) {
                                                    teamsActionsViewModel
                                                        .dropDownOnChanged(
                                                            value);
                                                  },
                                                  dropDownValue:
                                                      teamsActionsViewModel
                                                          .selectNewOwner,
                                                  dropDownItems: teamsViewModel
                                                      .teamDetails!.members!
                                                      .map((value) {
                                                    return DropdownMenuItem(
                                                      value:
                                                          value.id.toString(),
                                                      child: Text(
                                                        value.name.toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.74)),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  dropDownTitle: AppStrings
                                                      .listOfTeamUsers
                                                      .tr(),
                                                  onTapButton: () {
                                                    int? id = int.parse(
                                                        teamsActionsViewModel
                                                                .selectNewOwner ??
                                                            '');
                                                    teamsActionsViewModel
                                                        .leaveTeam(
                                                            context: context,
                                                            teamId: widget.id,
                                                            newOwnerId: id);
                                                  },
                                                  headerIcon: SvgPicture.asset(
                                                    "assets/images/svg/leave.svg",
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                  subTitle: AppStrings
                                                      .yourOrderWillBeDeliveredSoon
                                                      .tr()
                                                      .toLowerCase(),
                                                  buttonText: AppStrings
                                                      .leaveTeam
                                                      .tr());
                                            }),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      );
                    },
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
