import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/painter/teams/view_models/teams.actions.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  void showTermsAndConditionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(AppColors.bgC3),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0))),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(AppColors.bgC3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x00000000), // Adjust opacity as needed
                spreadRadius: 0,
                blurRadius: 11,
                offset: Offset(0, -4), // Shadow position
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: AppSizes.s16,
                bottom: AppSizes.s36,
                right: AppSizes.s24,
                left: AppSizes.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppImages.bottomSheet)),
                gapH64,
                const Text(
                  "Welcome to Oraint Paints, a recruitment app that aims to connect job seekers with employers. Your use of this application means your acceptance of this policy. We ask you to read this policy carefully before using the application.",
                  style: TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: Color(AppColors.black1Color)),
                ),
                gapH10,
                Text(
                  "1. Acceptance of the conditions".toUpperCase(),
                  style: const TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.oC2Color)),
                ),
                gapH10,
                const Text(
                  "Welcome to Oraint Paints, a recruitment app that aims to connect job seekers with employers. Your use of this application means your acceptance of this policy. We ask you to read this policy carefully before using the application.",
                  style: TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      height: 2,
                      color: Color(AppColors.black1Color)),
                ),
                gapH10,
                Text(
                  "1. Acceptance of the conditions".toUpperCase(),
                  style: const TextStyle(
                      fontSize: AppSizes.s12,
                      fontWeight: FontWeight.w500,
                      color: Color(AppColors.oC2Color)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController aboutTeamController = TextEditingController();
  final TextEditingController uploadImageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
        title: Text(
          AppStrings.createTeam.tr().toUpperCase(),
          style: const TextStyle(
              fontSize: AppSizes.s16,
              fontWeight: FontWeight.w700,
              color: Color(0XFF224982)),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFFFF007A).withOpacity(0.03),
                const Color(0xFF00A1FF).withOpacity(0.03)
              ],
            ),),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_)=>TeamsActionsViewModel(),
        child: Consumer<TeamsActionsViewModel>(
          builder: (context, teamsActionsViewModel, child) {
            if(teamsActionsViewModel.createTeamSuccess ==true){
              Fluttertoast.showToast(
                  msg: AppStrings.createTeamSuccessful.tr().toUpperCase(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              teamsActionsViewModel.createTeamSuccess = false;
            }
            return GradientBgImage(
              padding: EdgeInsets.zero,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: AppSizes.s24,
                      left: AppSizes.s24,
                      top: AppSizes.s10,
                      bottom: AppSizes.s32),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        gapH16,
                        defaultTextFormField(
                          controller: teamNameController,
                          hintText: AppStrings.teamName.tr().toUpperCase(),
                        ),
                        gapH18,
                        defaultTextFormField(
                          controller: aboutTeamController,
                          hintText: AppStrings.teamAbout.tr().toUpperCase(),
                        ),
                        gapH18,
                        defaultTextFormField(
                            controller: uploadImageController,
                            hintText: AppStrings.uploadImage.tr(),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                AppImages.uploadImage,
                                width: AppSizes.s15,
                                height: AppSizes.s15,
                              ),
                            )
                        ),
                        gapH82,
                        if(teamsActionsViewModel.isLoading)const Center(child: CircularProgressIndicator(),),
                        if(!teamsActionsViewModel.isLoading)ElevatedButton.icon(
                          onPressed: () {
                            teamsActionsViewModel.createTeam(context, teamNameController.text,
                                aboutTeamController.text);
                          },
                          icon: SvgPicture.asset(
                            AppImages.createTeam,
                            width: AppSizes.s24,
                            height: AppSizes.s24,
                          ),
                          label: Text(
                            AppStrings.createTeam.tr().toUpperCase(),
                            style: const TextStyle(
                                fontSize: AppSizes.s12,
                                fontWeight: FontWeight.w500,
                                color: Color(AppColors.textC5)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppColors.oC1Color),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.s50),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.s10, horizontal: AppSizes.s60),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.info),
            gapW8,
            Text(
              AppStrings.byCreatingATeamYouAgreeToThe.tr().toUpperCase(),
              style: const TextStyle(
                  fontSize: AppSizes.s8,
                  fontWeight: FontWeight.w500,
                  color: Color(AppColors.black1Color)),
            ),
            GestureDetector(
              onTap: () {
                showTermsAndConditionsBottomSheet(context);
              },
              child: Text(
                  AppStrings.termsAndConditions.tr().toUpperCase(),
                style: const TextStyle(
                    fontSize: AppSizes.s8,
                    fontWeight: FontWeight.w500,
                    color: Color(AppColors.oC2Color)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
