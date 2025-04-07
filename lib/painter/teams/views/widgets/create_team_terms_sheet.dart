import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/shared_more_screen/general_screen/logic/general_controller.dart';
import 'package:orient/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CreateTeamTermsSheet extends StatelessWidget {
  const CreateTeamTermsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height *0.7,
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
      child: ChangeNotifierProvider(create: (context) => GeneralController()..getGeneralData(context, slug: "teams-terms-and-conditions"),
        child: Consumer<GeneralController>(
          builder: (context, value, child) {
            return Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              body: (!value.isLoading)?Container(
                height: MediaQuery.sizeOf(context).height *0.7,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(
                          data: value.dataContent,
                          style: TextsStyles.htmlStyle),
                    ],
                  ),
                ),
              ): Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
