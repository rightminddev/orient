import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/painter/teams/view_models/teams.actions.viewmodel.dart';
import 'package:orient/painter/teams/view_models/teams.viewmodel.dart';
import 'package:orient/painter/teams/views/widgets/custom_button_bottom_sheet.dart';
import 'package:orient/painter/teams/views/widgets/custom_teams_appbar.dart';
import 'package:orient/painter/teams/views/widgets/team_members_list_view_item.dart';
import 'package:orient/painter/teams/views/widgets/team_memeber_request_listview.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import '../../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class TeamMembersScreen extends StatefulWidget {
  var id;
   TeamMembersScreen({
    super.key, required this.id
  });

  @override
  State<TeamMembersScreen> createState() => _TeamMembersScreenState();
}

class _TeamMembersScreenState extends State<TeamMembersScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>TeamsViewModel()..initializeTeamDetailsScreen(context, widget.id)),
      ChangeNotifierProvider(create: (_)=>TeamsActionsViewModel()),
    ],
    child: Consumer<TeamsViewModel>(
      builder: (context, teamsViewModel, child) {
        return Consumer<TeamsActionsViewModel>(
          builder: (context, teamsActionsViewModel, child) {
            if(teamsActionsViewModel.joinTeamSuccess == true){
              print("SUCCESS");
              Navigator.pop(context);
              teamsViewModel.initializeTeamDetailsScreen(context, widget.id);
              teamsActionsViewModel.joinTeamSuccess = false;
            }
            if(teamsActionsViewModel.leaveTeamSuccess == true){
              Navigator.pop(context);
              teamsViewModel.initializeTeamDetailsScreen(context, widget.id);
              teamsActionsViewModel.leaveTeamSuccess = false;
            }
            return  Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              body: (teamsViewModel.isLoading)?
              HomeLoadingPage(viewAppbar: false)
                  :GradientBgImage(
                padding: EdgeInsets.zero,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: height * 0.26, //250,
                      pinned: true,
                      backgroundColor: Colors.transparent,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
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
                                        bottomRight: Radius.circular(30)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        AppImages.teamMemberBackGround,
                                      ),
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    gapH64,
                                    CustomTeamsAppbar(
                                      popFun: () {
                                        Navigator.of(context).pop();
                                      },
                                      shareFun: () {},
                                      title: "Team Members",
                                    ),
                                    gapH36,
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(86),
                                            child: CachedNetworkImage(
                                              height: 86,
                                              width: 86,
                                              fit: BoxFit.cover,
                                              imageUrl: (teamsViewModel.teamDetails.image != null &&
                                                  teamsViewModel.teamDetails.image!.isNotEmpty)
                                                  ? teamsViewModel.teamDetails.image![0]!.file ?? ""
                                                  : "",
                                              placeholder: (context, url) =>
                                              const ShimmerAnimatedLoading(),
                                              errorWidget: (context, url, error) => const Icon(
                                                Icons.image_not_supported_outlined,
                                                size: AppSizes.s32,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          gapW16,
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${teamsViewModel.teamDetails.name}".toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: AppSizes.s20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(AppColors.textC5)),
                                              ),
                                              gapH6,
                                              Text(
                                                "${teamsViewModel.teamDetails.owner!.name}".toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: AppSizes.s14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(AppColors.textC5)),
                                              ),
                                              gapH6,
                                              Text(
                                                "${teamsViewModel.teamDetails.totalPoints} Points".toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: AppSizes.s12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(AppColors.textC5)),
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
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gapH20,
                            Text(
                              "your team".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: AppSizes.s14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppColors.oC2Color)),
                            ),
                            gapH6,
                            Container(
                              height: 300,
                              alignment: Alignment.center,
                              child: (teamsViewModel.teamDetails.members!.isNotEmpty)?ListView.builder(
                                itemCount: teamsViewModel.teamDetails.members!.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TeamMembersListViewItem(member: teamsViewModel.teamDetails.members, index: index);
                                },
                              ) : Center(
                                child: Text(
                                  "No Member Found!".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: AppSizes.s14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(AppColors.oC2Color)),
                                ),
                              ),
                            ),
                            gapH18,
                            Text(
                              "Members who would like to join your team"
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: AppSizes.s13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppColors.oC2Color)),
                            ),
                            gapH12,
                            ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: AppSizes.s8),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return const TeamMembersRequestListViewItem(
                                  isAdd: true,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: const Color(AppColors.bgC3),
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffC9CFD2).withOpacity(0.5),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonBottomSheet(
                          image: AppImages.userJoin,
                          title: "JOIN TEAM",
                          backGroundColor: AppColors.oC1Color,
                          function: () {
                            defaultActionBottomSheet(
                                context: context,
                                title: "Join team".toLowerCase(),
                                view: teamsActionsViewModel.isLoading,
                                onTapButton: (){
                                  teamsActionsViewModel.joinTeam(context, widget.id);
                                },
                                headerIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/images/svg/join.svg",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                subTitle: "By join to team you agree to the terms and conditions".toLowerCase(),
                                buttonText: "Join");
                          }),
                      gapW10,
                      CustomButtonBottomSheet(
                          image: AppImages.signOut,
                          title: "LEAVE TEAM",
                          backGroundColor: AppColors.red1Color,
                          function: () {
                            defaultActionBottomSheet(
                                context: context,
                                title: "Leave team".toLowerCase(),
                                view: teamsActionsViewModel.isLoading,
                                // viewDropDownButton: true,
                                // dropDownValue: "user1",
                                // dropDownItems: [
                                //   DropdownMenuItem(child: Text('user1'),value: "user1",),
                                //   DropdownMenuItem(child: Text('user2'),value: "user1",),
                                //   DropdownMenuItem(child: Text('user3'),value: "user1",)
                                // ],
                                dropDownTitle: "List of team users",
                                onTapButton: (){
                                  teamsActionsViewModel.leaveTeam(context, widget.id);
                                },
                                headerIcon: SvgPicture.asset(
                                  "assets/images/svg/leave.svg",
                                  width: 40,
                                  height: 40,
                                ),
                                subTitle: "Your order will be delivered soon."
                                    .toLowerCase(),
                                buttonText: "Leave team");
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
    );
  }
}
