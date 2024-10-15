import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';

import 'button_widget.dart';

class OrderContainerWidget extends StatelessWidget {
  const OrderContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER №1947034',
            style: TextStyle(
              color: Color(0xFFE6007E),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          TitleWithDataWidget(
            data: '05-12-2023',
            title: 'Date',
          ),
          TitleWithDataWidget(
            data: '950.0 EGP',
            title: 'Total Amount',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                onPressed: () {},
                borderSide:
                    const BorderSide(width: 1, color: Color(AppColors.oc1)),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "Details",
                fontColor: const Color(AppColors.oc1),
                backgroundColor: Colors.transparent,
              ),
              Text(
                'DELIVERED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2AA952),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TitleWithDataWidget extends StatelessWidget {
  final String title;
  final String data;
  const TitleWithDataWidget(
      {super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: TextStyle(
            color: Color(0xFFE6007E),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            color: Color(0xFF464646),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
