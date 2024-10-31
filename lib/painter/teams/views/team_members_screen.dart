import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/painter/teams/views/widgets/custom_button_bottom_sheet.dart';
import 'package:orient/painter/teams/views/widgets/custom_teams_appbar.dart';
import 'package:orient/painter/teams/views/widgets/team_members_list_view_item.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';

class TeamMembersScreen extends StatefulWidget {
  //final int id;

  const TeamMembersScreen({
    super.key, //required this.id
  });

  @override
  State<TeamMembersScreen> createState() => _TeamMembersScreenState();
}

class _TeamMembersScreenState extends State<TeamMembersScreen> {
  // late final TeamsViewModel viewModel;

  // @override
  // void initState() {
  //   super.initState();
  //   viewModel = TeamsViewModel();
  //   viewModel.initializeTeamDetailsScreen(context, widget.id, "teams");
  // }

  // void showCustomBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: const Color(AppColors.bgC3),
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
  //     builder: (context) {
  //       return Container(
  //         decoration: const BoxDecoration(
  //           color: Color(AppColors.bgC3),
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Color(0x00000000), // Adjust opacity as needed
  //               spreadRadius: 0,
  //               blurRadius: 11,
  //               offset: Offset(0, -4), // Shadow position
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.only(
  //               top: AppSizes.s36,
  //               bottom: AppSizes.s36,
  //               right: AppSizes.s24,
  //               left: AppSizes.s24),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               CustomButtonBottomSheet(
  //                   image: AppImages.userJoin,
  //                   title: "JOIN TEAM",
  //                   backGroundColor: AppColors.oC1Color,
  //                   function: () {}),
  //               gapW10,
  //               CustomButtonBottomSheet(
  //                   image: AppImages.signOut,
  //                   title: "LEAVE TEAM",
  //                   backGroundColor: AppColors.red1Color,
  //                   function: () {}),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                radius: 0.8,
                stops: [0.1, 1.0],
                center: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(255, 0, 123, 0.10),
                  Color.fromRGBO(0, 161, 255, 0.10)
                ])),
        child: Stack(
          children: [
            CustomScrollView(
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
                                      CircleAvatar(
                                        radius: AppSizes.s40,
                                        child: Image.asset(
                                          AppImages.user,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      gapW16,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "al-Nasr Group".toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: AppSizes.s20,
                                                fontWeight: FontWeight.w600,
                                                color: Color(AppColors.textC5)),
                                          ),
                                          gapH6,
                                          Text(
                                            "AHMED MOHAMED".toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: AppSizes.s14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(AppColors.textC5)),
                                          ),
                                          gapH6,
                                          Text(
                                            "7000 Points".toUpperCase(),
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
                        ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const TeamMembersListViewItem();
                          },
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
                            return const TeamMembersListViewItem(
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(AppColors.bgC3),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(
                          0, 0, 0, 0.1), // Adjust opacity as needed
                      spreadRadius: 0,
                      blurRadius: 11,
                      offset: Offset(0, -4), // Shadow position
                    ),
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
                                headerIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    ///
                                    "AppImages.joinTeam",
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                subTitle:
                                    "By join to team you agree to the terms and conditions"
                                        .toLowerCase(),
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
                               // viewDropDownButton: true,
                               // dropDownValue: "user1",
                                // dropDownItems: [
                                //   DropdownMenuItem(child: Text('user1'),value: "user1",),
                                //   DropdownMenuItem(child: Text('user2'),value: "user1",),
                                //   DropdownMenuItem(child: Text('user3'),value: "user1",)
                                // ],
                                dropDownTitle: "List of team users",
                                headerIcon: Image.asset(
                                  ///
                                  "AppImages.signout",
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
            ),
          ],
        ),
      ),
    );
  }
}
