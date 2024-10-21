import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';

class SingleListDetailsScreen extends StatelessWidget {
  const SingleListDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Notifications details".toUpperCase(),
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
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  "22 December 2023 , 02:00pm",
                  style: TextStyle(
                      fontSize: AppSizes.s10,
                      fontWeight: FontWeight.w400,
                      color: Color(AppColors.oC1Color)),
                ),
                gapH14,
                Text(
                  "Ramadan Kareem to you all and every year and you",
                  style: TextStyle(
                      fontSize: AppSizes.s16,
                      fontWeight: FontWeight.bold,
                      color: Color(AppColors.oC1Color)),
                ),
                gapH14,
                Text(
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
    );
  }
}
