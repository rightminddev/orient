import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants/app_sizes.dart';
import 'company_info_header_background_widget.dart';
import 'company_info_notched_container.dart';

class CompanyInfoHeader extends StatelessWidget {
  final String headerImage;
  final double notchedContainerHeight;
  final double backgroundHeight;
  final double notchRadius;
  final double notchPadding;
  final String notchImage;
  final String title;
  final String subtitle;
  const CompanyInfoHeader(
      {super.key,
      required this.notchImage,
      required this.notchPadding,
      required this.headerImage,
      required this.notchedContainerHeight,
      required this.backgroundHeight,
      required this.notchRadius,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: backgroundHeight +
          (notchedContainerHeight *
              0.35), // background image height + half of notched container height
      child: Stack(
        children: [
          CompanyInfoHeaderBackgroundWidget(
              headerImage: headerImage, backgroundHeight: backgroundHeight),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CompanyInfoNotchedContainer(
                notchedContainerHeight: notchedContainerHeight,
                notchRadius: notchRadius,
                notchPadding: notchPadding,
                notchImage: notchImage,
                title: title,
                subtitle: subtitle),
          ),
          Positioned(
            left: AppSizes.s12,
            top: MediaQuery.of(context).padding.top + AppSizes.s12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFA3A3A3).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSizes.s15),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: AppSizes.s18,
                        ),
                      ),
                    )),
                gapW8,
                const Text(
                  'Company Structure',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizes.s14,
                    letterSpacing: 1.4,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
