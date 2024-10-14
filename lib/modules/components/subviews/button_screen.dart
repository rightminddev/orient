import 'package:flutter/material.dart';
import 'package:orient/components/button_widget.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/settings/app_icons.dart';

import '../../../constants/app_colors.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "Save Changes",
                svgIcon: AppIcons.checkMarkDashed,
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "Delete Account",
                svgIcon: AppIcons.checkMarkDashed,
                backgroundColor: const Color(AppColors.red),
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s32, vertical: AppSizes.s16),
                title: "Continue shopping",
                svgIcon: AppIcons.continueShoppingCart,
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s64, vertical: AppSizes.s16),
                title: "Add store",
                svgIcon: AppIcons.checkMarkDashed,
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s36, vertical: AppSizes.s16),
                title: "Leave team",
                svgIcon: AppIcons.signOut,
                backgroundColor: const Color(AppColors.red1),
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s36, vertical: AppSizes.s16),
                title: "Redeem Now",
                svgIcon: AppIcons.redeem,
                backgroundColor: const Color(AppColors.oc2),
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                borderSide:
                    const BorderSide(width: 1, color: Color(AppColors.oc1)),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "CLEAR",
                fontColor: const Color(AppColors.oc1),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: AppSizes.s12),
              ButtonWidget(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s16, vertical: AppSizes.s0),
                title: "More",
                borderRadius: AppSizes.s8,
                fontSize: AppSizes.s12,
                backgroundColor: const Color(AppColors.oc2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
