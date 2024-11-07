import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class SingleListDetailsScreens extends StatelessWidget {
  const SingleListDetailsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 90,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          AppStrings.notificationsDetails.tr().toUpperCase(),
                          style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                            onPressed: (){}
                        ),
                      ],
                    ),
                  ),
                  gapH16,
                  Container(
                    //color: Colors.amber,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s25)),
                    child: Image.asset(
                      AppImages.testNotifi,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.225,
                    ),
                  ),
                  gapH24,
                  const Text(
                    "22 December 2023 , 02:00pm",
                    style: TextStyle(
                        fontSize: AppSizes.s10,
                        fontWeight: FontWeight.w400,
                        color: Color(AppColors.oC1Color)),
                  ),
                  gapH14,
                  const Text(
                    "Ramadan Kareem to you all and every year and you",
                    style: TextStyle(
                        fontSize: AppSizes.s16,
                        fontWeight: FontWeight.bold,
                        color: Color(AppColors.oC1Color)),
                  ),
                  gapH14,
                  const Text(
                    "With a continuous effort to hold a unique leading position in the industry, Orient brings together Egyptian manufacturing and German technology to offer products that you can rely on  With a continuous\n effort to hold a unique leading position in the industry, Orient brings together Egyptian manufacturing and German technology to offer products that you can rely on andandWith a continuous effort to hold a unique leading position in the industry, Orient brings together Egyptian manufacturing and German technology to offer products that you can rely on and a name you can trust.",
                    style: TextStyle(
                        fontSize: AppSizes.s12,
                        fontWeight: FontWeight.w400,
                        height: 2,
                        color: Color(AppColors.black1Color)),
                  ),
                  
                ],
              ),
            )),
      ),
    );
  }
}
