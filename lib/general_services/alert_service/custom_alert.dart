import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

import '../../constants/app_images.dart';
import '../../constants/app_sizes.dart';

class AlertType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  const AlertType(this.message, [this.color]);

  static const AlertType help = AlertType('help', DefaultColors.helpBlue);
  static const AlertType failure =
      AlertType('failure', DefaultColors.failureRed);
  static const AlertType success =
      AlertType('success', DefaultColors.successGreen);
  static const AlertType warning =
      AlertType('warning', DefaultColors.warningYellow);
}

class DefaultColors {
  /// help
  static const Color helpBlue = Color(0xff3282B8);

  /// failure
  static const Color failureRed = Color(0xffc72c41);

  /// success
  static const Color successGreen = Color(0xff2D6A4F);

  /// warning
  static const Color warningYellow = Color(0xffFCA652);
}

class CustomAlert extends StatelessWidget {
  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// behavior: SnackBarBehavior.floating
  /// elevation: 0.0

  /// /// `IMPORTANT NOTE` for MaterialBanner properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// forceActionsBelow: true,
  /// elevation: 0.0
  /// [inMaterialBanner = true]

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar/MaterialBanner body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
  final AlertType contentType;

  /// if you want to use this in materialBanner
  final bool inMaterialBanner;

  /// if you want to customize the font size of the title
  final double? titleFontSize;

  /// if you want to customize the font size of the message
  final double? messageFontSize;

  const CustomAlert({
    super.key,
    this.color,
    this.titleFontSize,
    this.messageFontSize,
    required this.title,
    required this.message,
    required this.contentType,
    this.inMaterialBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    final size = MediaQuery.of(context).size;

    // screen dimensions
    bool isMobile = size.width <= 768;
    bool isTablet = size.width > 768 && size.width <= 992;

    /// for reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    double horizontalPadding = 0.0;
    double leftSpace = size.width * 0.12;
    double rightSpace = size.width * 0.12;

    if (isMobile) {
      horizontalPadding = AppSizes.s16;
    } else if (isTablet) {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.2;
    } else {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.3;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      height: size.height * 0.125,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// background container
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(AppSizes.s20),
            ),
          ),

          /// Splash SVG asset
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                AppImages.alertsBubbles,
                height: size.height * 0.06,
                width: size.width * 0.05,
                colorFilter:
                    _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
              ),
            ),
          ),

          // Bubble Icon
          Positioned(
            top: -size.height * 0.01,
            left: !isRTL
                ? leftSpace -
                    8 -
                    (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            right: isRTL
                ? rightSpace -
                    8 -
                    (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.alertsBack,
                  height: size.height * 0.06,
                  colorFilter:
                      _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                ),
                Positioned(
                  top: size.height * 0.015,
                  child: SvgPicture.asset(
                    assetSVG(contentType),
                    height: size.height * 0.022,
                  ),
                )
              ],
            ),
          ),

          /// content
          Positioned.fill(
            left: isRTL ? size.width * 0.03 : leftSpace,
            right: isRTL ? rightSpace : size.width * 0.03,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// `title` parameter
                      Expanded(
                        flex: 3,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: titleFontSize ??
                                (!isMobile
                                    ? size.height * 0.03
                                    : size.height * 0.025),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          if (inMaterialBanner) {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                            return;
                          }
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: SvgPicture.asset(
                          AppImages.alertsFailure,
                          height: size.height * 0.022,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),

                  /// `message` body text parameter
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: messageFontSize ?? size.height * 0.016,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(AlertType contentType) {
    switch (contentType) {
      case AlertType.failure:

        /// failure will show `CROSS`
        return AppImages.alertsFailure;
      case AlertType.success:

        /// success will show `CHECK`
        return AppImages.alertsSuccess;
      case AlertType.warning:

        /// warning will show `EXCLAMATION`
        return AppImages.alertsWarning;
      case AlertType.help:

        /// help will show `QUESTION MARK`
        return AppImages.alertsHelp;
      default:
        return AppImages.alertsFailure;
    }
  }

  static ColorFilter? _getColorFilter(
          ui.Color? color, ui.BlendMode colorBlendMode) =>
      color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
}
