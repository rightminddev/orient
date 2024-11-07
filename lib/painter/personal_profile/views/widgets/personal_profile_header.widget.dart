import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../general_services/layout.service.dart';
import '../../../../routing/app_router.dart';
import '../../viewmodels/personal_profile.viewmodel.dart';

class PersonalProfileHeaderWidget extends StatelessWidget {
  final PersonalProfileViewModel viewModel;
  final String headerImage;
  final double notchedContainerHeight;
  final double backgroundHeight;
  final double notchRadius;
  final double notchPadding;
  final String notchImage;
  final String title;
  final String subtitle;
  final double circleBorderWidth;
  const PersonalProfileHeaderWidget(
      {super.key,
      required this.viewModel,
      required this.notchImage,
      required this.notchPadding,
      required this.headerImage,
      required this.notchedContainerHeight,
      required this.backgroundHeight,
      required this.notchRadius,
      required this.title,
      required this.subtitle,
      required this.circleBorderWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: LayoutService.getWidth(context),
      height: backgroundHeight +
          (notchedContainerHeight *
              0.35), // background image height + half of notched container height
      child: Stack(
        children: [
          PersonalProfileHeaderBackgroundWidget(
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
              subtitle: subtitle,
              circleBorderWidth: circleBorderWidth,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSizes.s12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s12),
              width: LayoutService.getWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Text(
                    'Account & Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.s14,
                      letterSpacing: 1.4,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFA3A3A3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSizes.s15),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async =>
                              await viewModel.logout(context: context),
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                            size: AppSizes.s18,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalProfileHeaderBackgroundWidget extends StatelessWidget {
  final String headerImage;
  final double? backgroundHeight;
  const PersonalProfileHeaderBackgroundWidget(
      {super.key, required this.headerImage, required this.backgroundHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: backgroundHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(headerImage), fit: BoxFit.fill)),
        child: Stack(
          children: [
            Positioned.fill(
                child: Column(
              children: [
                Container(
                  height: backgroundHeight != null
                      ? backgroundHeight! / 2
                      : double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5],
                    ),
                  ),
                ),
                Container(
                    height: backgroundHeight != null
                        ? backgroundHeight! / 2
                        : double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5],
                      ),
                    )),
              ],
            ))
          ],
        ));
  }
}

class CompanyInfoNotchedContainer extends StatelessWidget {
  final double notchedContainerHeight;
  final double notchRadius;
  final double notchPadding;
  final String notchImage;
  final String title;
  final String subtitle;
  final double circleBorderWidth;
  const CompanyInfoNotchedContainer(
      {super.key,
      required this.notchImage,
      required this.notchPadding,
      required this.notchRadius,
      required this.notchedContainerHeight,
      required this.title,
      required this.circleBorderWidth,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: notchedContainerHeight,
      width: LayoutService.getWidth(context),
      child: Stack(
        children: [
          Positioned(
              top: AppSizes.s6,
              left: 0,
              right: 0,
              child: Center(
                  child: Container(
                width: (notchRadius - notchPadding) * 2,
                height: (notchRadius - notchPadding) * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: circleBorderWidth,
                  ),
                ),
                child: InkWell(
                  onTap: () async => await context.pushNamed(
                      AppRoutes.companyTree.name,
                      pathParameters: {'lang': context.locale.languageCode}),
                  child: CircleAvatar(
                    radius: notchRadius - notchPadding - circleBorderWidth,
                    backgroundColor: const Color(0xff224982),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.s12),
                      child: Image(
                        image: AssetImage(
                          notchImage,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: PersonalProfileCustomNotchClipper(
                  notchSize: (notchRadius * 2) + (notchPadding * 2)),
              child: Container(
                padding: EdgeInsets.only(
                    top: notchRadius / 2,
                    left: AppSizes.s8,
                    right: AppSizes.s8),
                height: notchedContainerHeight - (notchRadius + notchPadding),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.s32),
                    topRight: Radius.circular(AppSizes.s32),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      title,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                    gapH12,
                    AutoSizeText(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalProfileCustomNotchClipper extends CustomClipper<Path> {
  final double notchSize;

  PersonalProfileCustomNotchClipper({required this.notchSize});

  @override
  Path getClip(Size size) {
    final double radius = notchSize / 2;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo((size.width - notchSize) / 2, 0)
      ..arcToPoint(
        Offset((size.width + notchSize) / 2, 0),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
