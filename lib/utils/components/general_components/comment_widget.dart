import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/cached_network_image_widget.dart';
import 'package:orient/utils/media_query_values.dart';

class CommentWidget extends StatelessWidget {
  final String image;
  final double? imageRadius;
  final bool isImageUrl;
  final String name;
  final String date;
  final String? comment;
  final String? rate;
  final bool isVerified;
  final Color? nameFontColor;
  final FontWeight? nameFontWeight;
  final double? nameFontSize;

  final Color? dateFontColor;
  final FontWeight? dateFontWeight;
  final double? dateFontSize;

  final Color? commentFontColor;
  final FontWeight? commentFontWeight;
  final double? commentFontSize;

  final Color? rateFontColor;
  final FontWeight? rateFontWeight;
  final double? rateFontSize;
  const CommentWidget({
    super.key,
    required this.image,
    this.imageRadius,
    this.isImageUrl = true,
    this.dateFontColor,
    this.dateFontWeight,
    this.dateFontSize,
    required this.name,
    required this.date,
    this.comment,
    this.rate,
    this.nameFontColor,
    this.nameFontWeight,
    this.nameFontSize,
    this.commentFontColor,
    this.commentFontWeight,
    this.commentFontSize,
    this.rateFontColor,
    this.rateFontWeight,
    this.rateFontSize,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s8, horizontal: AppSizes.s12),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: context.width * 0.15,
            height: context.width * 0.15,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xffE6007E), Color(0xff224982)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(63),
                child: isImageUrl == true
                    ? CachedNetWokImageWidget(
                  url: image,
                  width: imageRadius != null
                      ? imageRadius! * 2
                      : context.width * 0.15,
                  height: imageRadius != null
                      ? imageRadius! * 2
                      : context.width * 0.15,
                  radius: imageRadius ?? context.width * 0.08,
                )
                    : Image.asset(
                  image,
                  width: imageRadius != null
                      ? imageRadius! * 2
                      : context.width * 0.15,
                  height: imageRadius != null
                      ? imageRadius! * 2
                      : context.width * 0.15,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSizes.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                fontWeight: nameFontWeight ?? FontWeight.w600,
                                color: nameFontColor ??
                                    AppThemeService
                                        .colorPalette.secondaryTextColor.color,
                                fontSize: nameFontSize,
                              ),
                        ),
                        isVerified == true
                            ? Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: SvgPicture.asset(
                                  AppIcons.checkMarkDashed,
                                  width: 12,
                                  height: 12,
                                  colorFilter: ColorFilter.mode(
                                      AppThemeService.colorPalette
                                          .quaternaryTextColor.color,
                                      BlendMode.srcIn),
                                  fit: BoxFit.scaleDown,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: dateFontWeight,
                            color: dateFontColor ??
                                AppThemeService
                                    .colorPalette.quaternaryTextColor.color,
                            fontSize: dateFontSize,
                          ),
                    )
                  ],
                ),
                SizedBox(height:comment != null ? 5 : 0,),
                comment != null ? Text(
                        comment!,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: commentFontWeight,
                              color: commentFontColor ??
                                  AppThemeService
                                      .colorPalette.tertiaryTextColor.color,
                              fontSize: commentFontSize ?? AppSizes.s10,
                            ),
                      ) : SizedBox.shrink(),
                SizedBox(height:rate != null ? 5 : 0,),
                rate != null ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: ShapeDecoration(
                          color: Color(0xffFFFABB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.s18),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '5',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: commentFontWeight,
                                    color: commentFontColor ??
                                        AppThemeService.colorPalette
                                            .tertiaryTextColor.color,
                                    fontSize: commentFontSize,
                                  ),
                            ),
                            SvgPicture.asset(
                              AppIcons.star,
                            ),
                          ],
                        ),
                      ) : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
