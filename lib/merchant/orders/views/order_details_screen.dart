import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/common_modules_widgets/template_page.widget.dart';
import 'package:orient/constants/app_strings.dart';

import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/text_with_space_between.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      backgroundColor: Colors.white,
      pageContext: context,
      title: AppStrings.orderDetails.tr(),
      body: GradientBgImage(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 18),
              TextWithSpaceBetween(
                textOnLeft: 'ORDER №1947034',
                textOnRight: '05-12-2023',
              ),
              const SizedBox(height: 12),
              TrackingOrderTextWidget(
                textOnLeft: 'IW3475453455',
                textOnRight: 'DELIVERED',
              ),
              const SizedBox(height: 12),
              Text(
                'ORDER INFORMATION',
                style: TextStyle(
                  color: Color(0xFFE6007E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
