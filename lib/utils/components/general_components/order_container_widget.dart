import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';

import '../../../merchant/orders/views/order_details_screen.dart';
import '../../../models/orders/order_model.dart';
import 'button_widget.dart';

class OrderContainerWidget extends StatelessWidget {
  final OrderModel orderModel;
  final int storeId;
  const OrderContainerWidget(
      {super.key, required this.orderModel, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER № ${orderModel.uuid}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppThemeService.colorPalette.secondaryTextColor.color,
                  height: 0,
                  letterSpacing: 0,
                ),
          ),
          TitleWithDataWidget(
            data: orderModel.date ?? '',
            title: 'Date',
          ),
          TitleWithDataWidget(
            data: '${orderModel.total} EGP', //TODO: currency
            title: 'Total Amount',
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(
                        storeId: storeId,
                        orderId: orderModel.id ?? 0,
                      ),
                    ),
                  );
                },
                borderSide:
                    const BorderSide(width: 1, color: Color(AppColors.oc1)),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "Details",
                fontColor: const Color(AppColors.oc1),
                backgroundColor: Colors.transparent,
              ),
              Text(
                orderModel.status ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF2AA952),
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
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppThemeService.colorPalette.secondaryTextColor.color,
              ),
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppThemeService.colorPalette.quaternaryTextColor.color,
              ),
        ),
      ],
    );
  }
}
