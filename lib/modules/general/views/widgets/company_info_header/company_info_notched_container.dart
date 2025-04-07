import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../routing/app_router.dart';

class CompanyInfoNotchedContainer extends StatelessWidget {
  final double notchedContainerHeight;
  final double notchRadius;
  final double notchPadding;
  final String notchImage;
  final String title;
  final String subtitle;
  const CompanyInfoNotchedContainer(
      {super.key,
      required this.notchImage,
      required this.notchPadding,
      required this.notchRadius,
      required this.notchedContainerHeight,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: notchedContainerHeight,
          width: MediaQuery.sizeOf(context).width - AppSizes.s20,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
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
                        width: 2.0,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async => await context.pushNamed(
                          AppRoutes.companyTree.name,
                          pathParameters: {
                            'lang': context.locale.languageCode
                          }),
                      child: CircleAvatar(
                        radius: notchRadius - notchPadding - 2.0,
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
                  clipper: CustomNotchClipper(
                      notchSize: (notchRadius * 2) + (notchPadding * 2)),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: notchRadius / 2,
                          left: AppSizes.s8,
                          right: AppSizes.s8),
                      height:
                          notchedContainerHeight - (notchRadius + notchPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomNotchClipper extends CustomClipper<Path> {
  final double notchSize;

  CustomNotchClipper({required this.notchSize});

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
