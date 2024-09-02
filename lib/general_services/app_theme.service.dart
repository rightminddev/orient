import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/app_sizes.dart';
import '../models/color_palette.model.dart';
import '../models/color_value.model.dart';
import 'localization.service.dart';

abstract class AppThemeService {
  static final ColorPalette colorPalette = ColorPalette(
    name: 'Main Theme',
    // application primary colors
    primaryColor: ColorValue(
        light: const Color(AppColors.c1), dark: const Color(AppColors.c1)),
    secondaryColor: ColorValue(
        light: const Color(AppColors.c2), dark: const Color(AppColors.c2)),
    tertiaryColor: ColorValue(
        light: const Color(AppColors.c3), dark: const Color(AppColors.c3)),
    // application background colors
    primaryColorBackground: ColorValue(
        light: const Color(AppColors.bgC1), dark: const Color(AppColors.bgC1)),
    secondaryColorBackground: ColorValue(
        light: const Color(AppColors.bgC2), dark: const Color(AppColors.bgC2)),
    tertiaryColorBackground: ColorValue(
        light: const Color(AppColors.bgC3), dark: const Color(AppColors.bgC3)),
    // application texts colors
    primaryTextColor: ColorValue(
        light: const Color(AppColors.textC1),
        dark: const Color(AppColors.textC1)),
    secondaryTextColor: ColorValue(
        light: const Color(AppColors.textC2),
        dark: const Color(AppColors.textC2)),
    tertiaryTextColor: ColorValue(
        light: const Color(AppColors.textC3),
        dark: const Color(AppColors.textC3)),
    quaternaryTextColor: ColorValue(
        light: const Color(AppColors.textC4),
        dark: const Color(AppColors.textC4)),
    quinaryTextColor: ColorValue(
        light: const Color(AppColors.textC5),
        dark: const Color(AppColors.textC5)),
    //scaffold colors
    appBarBackgroundColor: ColorValue(
        light: const Color(AppColors.appBarBackgroundColor),
        dark: const Color(AppColors.appBarBackgroundColor)),
    bodyBackgroundColor: ColorValue(
        light: const Color(AppColors.bodyBackgroundColor),
        dark: const Color(AppColors.bodyBackgroundColor)),
    btmAppBarBackgroundColor: ColorValue(
        light: const Color(AppColors.btmAppBarBackgroundColor),
        dark: const Color(AppColors.btmAppBarBackgroundColor)),
    fabBackgroundColor: ColorValue(
        light: const Color(AppColors.fabBackgroundColor),
        dark: const Color(AppColors.fabBackgroundColor)),
    fabIconColor: ColorValue(
        light: const Color(AppColors.fabIconColor),
        dark: const Color(AppColors.fabIconColor)),
    // input colors
    inputBorderColor: ColorValue(
        light: const Color(AppColors.inputBorderColor),
        dark: const Color(AppColors.inputBorderColor)),
    inputFillColor: ColorValue(
        light: const Color(AppColors.inputFillColor),
        dark: const Color(AppColors.inputFillColor)),
    inputHintColor: ColorValue(
        light: const Color(AppColors.inputHintColor),
        dark: const Color(AppColors.inputHintColor)),
    inputLabelColor: ColorValue(
        light: const Color(AppColors.inputLabelColor),
        dark: const Color(AppColors.inputLabelColor)),
    inputTextColor: ColorValue(
        light: const Color(AppColors.inputTextColor),
        dark: const Color(AppColors.inputTextColor)),
  );
  static TextTheme _textTheme(
          {required bool isDark, required BuildContext context}) =>
      TextTheme(
        displayLarge: TextStyle(
          // --> used
          fontSize: AppSizes.s22,
          fontWeight: FontWeight.w600,
          color: colorPalette.secondaryTextColor.get(isDark),
        ),
        displayMedium: TextStyle(
            // --> used
            letterSpacing: LocalizationService.isArabic(context: context)
                ? null
                : AppSizes.s12,
            height: AppSizes.s6,
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        displaySmall: TextStyle(
          // --> used
          fontSize: AppSizes.s14,
          fontWeight: FontWeight.w400,
          color: colorPalette.quaternaryTextColor.get(isDark),
        ),
        labelLarge: const TextStyle(
            // --> used
            fontWeight: FontWeight.w700,
            fontSize: AppSizes.s24,
            color: Colors.white),
        headlineMedium: TextStyle(
            // --> used
            letterSpacing:
                LocalizationService.isArabic(context: context) ? null : 1.2,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.s13),
        headlineSmall: TextStyle(
            // --> used
            fontWeight: FontWeight.w600,
            color: colorPalette.quinaryTextColor.color,
            fontSize: AppSizes.s16,
            letterSpacing:
                LocalizationService.isArabic(context: context) ? null : 1.6),
        headlineLarge: TextStyle(
            // --> used for the title of modal sheet
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.s20,
            color: colorPalette.secondaryTextColor.color),
        bodySmall: TextStyle(
          // --> used
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.s10,
          letterSpacing:
              LocalizationService.isArabic(context: context) ? null : 1,
          color: const Color(0xFF474747),
        ),
        bodyMedium: TextStyle(
          // -> used
          fontSize: AppSizes.s14,
          fontWeight: FontWeight.w500,
          color: colorPalette.secondaryTextColor.get(isDark),
        ),
        bodyLarge: TextStyle(
            // -> used for style of the input text
            color: colorPalette.inputTextColor.color),
        labelSmall: TextStyle(
          //-> used
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.s12,
          letterSpacing:
              LocalizationService.isArabic(context: context) ? null : 0.5,
          color: const Color(0xFF3B3B3B),
        ),
        titleLarge: const TextStyle(
          // --> used
          fontWeight: FontWeight.w500,
          fontSize: AppSizes.s20,
          height: 1.0,
          color: Colors.white,
        ),
        titleSmall: const TextStyle(
          //--> used
          fontWeight: FontWeight.normal,
          fontSize: AppSizes.s12,
          height: 1.0,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          //-- >used
          fontSize: AppSizes.s14,
          fontWeight: FontWeight.w500,
          letterSpacing:
              LocalizationService.isArabic(context: context) ? null : 0.75,
          height: 1.1,
          color: colorPalette.primaryTextColor.get(isDark).withOpacity(.75),
        ),
        titleMedium: const TextStyle(
          fontSize: AppSizes.s17,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );

  static ThemeData getTheme(
          {required bool isDark, required BuildContext context}) =>
      ThemeData(
        // application font family
        fontFamily: LocalizationService.isArabic(context: context)
            ? AppConstants.fontFamilyMontserratArabic
            : AppConstants.fontFamilyPoppins,
        // application input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              color: colorPalette.inputHintColor.color,
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.s12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s15),
            borderSide: BorderSide(
                color: colorPalette.inputBorderColor.color, width: AppSizes.s1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s15),
            borderSide: BorderSide(
                color: colorPalette.inputBorderColor.color, width: AppSizes.s1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s15),
            borderSide: BorderSide(
                color: colorPalette.inputBorderColor.color, width: AppSizes.s1),
          ),
          labelStyle: TextStyle(
            color: colorPalette.inputLabelColor.color,
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.s12,
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(AppSizes.s20),
          fillColor: colorPalette.inputFillColor.color,
          isDense: true,
        ),
        //application card theme
        cardTheme: CardTheme(color: colorPalette.tertiaryColorBackground.color),
        // application fab theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorPalette.fabBackgroundColor.color,
          shape: const CircleBorder(),
        ),
        // application appbar theme
        appBarTheme: AppBarTheme(
          backgroundColor: colorPalette.appBarBackgroundColor.color,
          elevation: AppSizes.s0,
          centerTitle: true,
        ),
        // application text theme
        textTheme: _textTheme(context: context, isDark: isDark).apply(
          fontFamily: LocalizationService.isArabic(context: context)
              ? AppConstants.fontFamilyMontserratArabic
              : AppConstants.fontFamilyPoppins,
        ),
        // application theme
        brightness: isDark ? Brightness.dark : Brightness.light,
        // application btm nav bar theme
        bottomAppBarTheme: BottomAppBarTheme(
          color: colorPalette.btmAppBarBackgroundColor.color,
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: isDark ? Brightness.dark : Brightness.light,
          secondary: colorPalette.secondaryColor.get(isDark),
          seedColor: colorPalette.primaryColor.get(isDark),
          primary: colorPalette.primaryColor.get(isDark),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          foregroundColor: colorPalette.quinaryTextColor.color,
          backgroundColor: colorPalette.primaryColorBackground.color,
        )),
        textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, double.infinity),
          backgroundColor: Colors.transparent,
          foregroundColor: colorPalette.secondaryColor.color,
          elevation: 0,
        )),

        tabBarTheme: TabBarTheme(
          dividerHeight: 0,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(
            fontSize: AppSizes.s16,
            fontFamily: AppConstants.fontFamilyPoppins,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: colorPalette.tertiaryTextColor.color,
          unselectedLabelStyle: const TextStyle(
              fontSize: AppSizes.s16,
              fontFamily: AppConstants.fontFamilyPoppins,
              fontWeight: FontWeight.bold),
          labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
        ),

        popupMenuTheme: PopupMenuThemeData(
          color: colorPalette.tertiaryColorBackground.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12),
          ),
          elevation: AppSizes.s8,
        ),
      );
}
