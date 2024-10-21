import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/teams/views/rated_team_screen.dart';
import 'package:orient/modules/teams/views/team_members_screen.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "teams".toUpperCase(),
          style: const TextStyle(
              fontSize: AppSizes.s16,
              fontWeight: FontWeight.w700,
              color: Color(0XFF224982)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  radius: 0.8,
                  stops: [0.1, 1.0],
                  center: Alignment.centerLeft,
                  colors: [
                    Color.fromRGBO(255, 0, 123, 0.10),
                    Color.fromRGBO(0, 161, 255, 0.10)
                  ])),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                radius: 0.8,
                stops: [0.1, 1.0],
                center: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(255, 0, 123, 0.10),
                  Color.fromRGBO(0, 161, 255, 0.10)
                ])),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24, vertical: AppSizes.s10),
          child: Column(
            children: [
              Row(
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
                          return RatedTeamScreen();
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
              ),
              gapH16,
              ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return TeamMembersScreen();
                        },
                      ));
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.symmetric(vertical: AppSizes.s8),
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
                                  backgroundImage:
                                      AssetImage(AppImages.circleNotification),
                                ),
                                gapW10,
                                Text(
                                  "best first paints".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: AppSizes.s14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(AppColors.black1Color)),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.s20, vertical: 9),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.s5),
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
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: AppSizes.s70,
        height: AppSizes.s70,
        child: FloatingActionButton.large(
          onPressed: () {},
          backgroundColor: const Color(AppColors.oC2Color),
          child: const Icon(
            Icons.add,
            size: AppSizes.s28,
            color: Color(AppColors.textC5),
          ),
        ),
      ),
    );
  }
}
