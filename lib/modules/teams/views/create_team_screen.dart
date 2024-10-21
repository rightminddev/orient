import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';

class CreateTeamScreen extends StatelessWidget {
  const CreateTeamScreen({super.key});

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
                color: Color(000000), // Adjust opacity as needed
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "create team".toUpperCase(),
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
        child: Padding(
          padding: const EdgeInsets.only(
              right: AppSizes.s24,
              left: AppSizes.s24,
              top: AppSizes.s10,
              bottom: AppSizes.s32),
          child: Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    gapH16,
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Team Name*'.toUpperCase(),
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle: const TextStyle(
                            fontSize: AppSizes.s12,
                            fontWeight: FontWeight.w400,
                            color: Color(AppColors.grey1Color)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.inputBorderColor))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.inputBorderColor))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.oC2Color))),
                      ),
                    ),
                    gapH18,
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'About Team'.toUpperCase(),
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle: const TextStyle(
                            fontSize: AppSizes.s12,
                            fontWeight: FontWeight.w400,
                            color: Color(AppColors.grey1Color)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.inputBorderColor))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.inputBorderColor))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.oC2Color))),
                      ),
                    ),
                    gapH18,
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Upload Image'.toUpperCase(),
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle: const TextStyle(
                            fontSize: AppSizes.s12,
                            fontWeight: FontWeight.w400,
                            color: Color(AppColors.grey1Color)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.inputBorderColor))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.inputBorderColor))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                            borderSide: const BorderSide(
                                color: Color(AppColors.oC2Color))),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            AppImages.uploadImage,
                            width: AppSizes.s15,
                            height: AppSizes.s15,
                          ),
                        ),
                      ),
                    ),
                    gapH82,
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppImages.createTeam,
                        width: AppSizes.s24,
                        height: AppSizes.s24,
                      ),
                      label: Text(
                        "Create Team".toUpperCase(),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.info),
                    gapW8,
                    Text(
                      "By creating a team you agree to the ".toUpperCase(),
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
                        "terms and conditions".toUpperCase(),
                        style: const TextStyle(
                            fontSize: AppSizes.s8,
                            fontWeight: FontWeight.w500,
                            color: Color(AppColors.oC2Color)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
