import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/models/teams/team_model.dart';
import 'package:orient/modules/painters/teams/views/team_members_screen.dart';

class TeamsListViewItem extends StatelessWidget {
  final TeamModel model;

  const TeamsListViewItem({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return TeamMembersScreen(
              id: model.id??-1,
            );
          },
        ));
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
                  CircleAvatar(
                    radius: AppSizes.s22,
                    backgroundImage:
                        NetworkImage(model.image![0].thumbnail ?? ""),
                  ),
                  gapW10,
                  Text(
                    model.name ?? "".toUpperCase(),
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
