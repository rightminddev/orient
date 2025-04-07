import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/models/people/member_model.dart';
import 'package:orient/painter/teams/view_models/teams.actions.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';

class LeaveTeamBottomsheet extends StatelessWidget {
  List<MemberModel>? members = [];
  var id;
  bool viewDrop =false;
  LeaveTeamBottomsheet({super.key, this.members, this.id, required this.viewDrop});

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamsActionsViewModel>(builder:
    (context, teamsActionsViewModel, child) {
      return GestureDetector(
        onTap: () {}, // Prevent taps inside from closing the bottom sheet
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
            gradient: LinearGradient(
              colors: [Color(0xffFDFDFD), Color(0xffF4F7FF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.52,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Center(
                child: Container(
                  height: 5,
                  width: 63,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xffB9C0C9),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffE6007E).withOpacity(0.05),
                      ),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffE6007E),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/svg/leave.svg",
                            width: 40,
                            height: 40,
                          )),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.leaveTeam.tr().toLowerCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xffE6007E),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      AppStrings
                          .yourOrderWillBeDeliveredSoon
                          .tr()
                          .toLowerCase(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1B1B1B),
                          fontFamily: "Poppins"),
                      textAlign: TextAlign.center,
                    ),
                    if(viewDrop == true) const SizedBox(height: 10),
                   if(viewDrop == true) Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.5),
                          child: Container(
                            height: 49,
                            decoration: BoxDecoration(
                              color: const Color(0xffE6007E),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        defaultDropdownField(
                            items: members!.map((value) {return DropdownMenuItem(
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
                            title: teamsActionsViewModel.selectNewOwner??AppStrings.listOfTeamUsers.tr(),
                            value: teamsActionsViewModel.selectNewOwner,
                            onChanged:  (String? value) {
                              teamsActionsViewModel.dropDownOnChanged(value);
                            },),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (teamsActionsViewModel.isLeaveLoading == true)const Center(child: CircularProgressIndicator()),
                    if (teamsActionsViewModel.isLeaveLoading == false)GestureDetector(
                        onTap: () {
                   // int? id = int.parse(
                   //     teamsActionsViewModel
                   //         .selectNewOwner ??
                   //         '');
                   teamsActionsViewModel
                       .leaveTeam(
                   context: context,
                   teamId: id,
                   newOwnerId: (viewDrop == true)?teamsActionsViewModel.selectNewOwner : null
                   );
                   },
                        child: Container(
                          height: 50,
                          width: 225,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xff0D3B6F)),
                          child: Text(
                            AppStrings
                                .leaveTeam
                                .tr(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFFFFFF),
                                fontFamily: "Poppins"),
                          ),
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
    );
  }
}
