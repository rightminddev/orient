import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/models/invoice_model.dart';
import 'package:orient/routing/app_router.dart';

import '../../../merchant/orders/models/order_status.dart';
import '../../../models/orders/order_model.dart';
import 'button_widget.dart';

class OrderContainerWidget extends StatelessWidget {
   OrderModel? orderModel;
   InvoiceModel? invoiceModel;
  var orders;
  bool invoiceDetails = false;
  String? invoice = "no";
  String? goToInvoice = "no";
  final int storeId;
  var orderId;
  var odoo;
   OrderContainerWidget(
      {super.key,this.orderModel,this.goToInvoice,this.orderId,required this.invoiceDetails,this.invoiceModel,this.invoice, required this.storeId, this.odoo, this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
           invoice == "yes" ?'${AppStrings.orderNo.tr().toUpperCase()} ${invoiceModel!.invoiceName ?? ""}' : odoo == "no" ?'${AppStrings.orderNo.tr().toUpperCase()} ${orderModel!.uuid}':'${AppStrings.orderNo.tr().toUpperCase()} ${orders['sales_order_name']}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppThemeService.colorPalette.secondaryTextColor.color,
                  height: 0,
                  letterSpacing: 0,
                ),
          ),
          TitleWithDataWidget(
            status: false,
            data: invoice == "yes" ?'${invoiceModel!.invoiceDateOnly ?? ""}':odoo == "no" ?orderModel!.date ?? '' : orders['sales_order_date_only'],
            title: AppStrings.date.tr(),
          ),
          TitleWithDataWidget(
            status: false,
            data:invoice == "yes" ?'${invoiceModel!.invoiceAmount ?? "0"}':odoo == "no" ? '${orderModel!.total} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}':'${orders['sales_order_amount']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}', //TODO: currency
            title: AppStrings.totalAmount.tr(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                isLoading: false,
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => OrderDetailsScreen(
                  //       storeId: storeId,
                  //       orderId: orderModel!.id ?? 0,
                  //     ),
                  //   ),
                  // );
                  Offset begin = const Offset(1.0, 0.0);
                  if(invoiceDetails == true){
                    context.pushNamed(
                      AppRoutes.invoiceDetails.name,
                      pathParameters: {
                        "orderId": orderId.toString(),
                        "storeId": storeId.toString(),
                        "invoiceId" : invoiceModel!.invoiceId.toString(),
                        "id" : orderId.toString(),
                        "odoo" : "yes",
                        "invoice" : "yes",
                        "goToInvoice" : "yes",
                        'lang': context.locale.languageCode,
                      },
                      queryParameters: {
                        'lang': context.locale.languageCode,
                      },
                      extra: begin,
                    );
                  }else{
                    if(goToInvoice == "yes" && odoo == "yes"){
                      context.pushNamed(
                        AppRoutes.orderInvoice.name,
                        pathParameters: {
                          "orderId": orders['sales_order_id'].toString(),
                          "storeId": storeId.toString(),
                          'lang': context.locale.languageCode,
                        },
                        queryParameters: {
                          'lang': context.locale.languageCode,
                        },
                        extra: begin,
                      );
                    }
                    else {
                      context.pushNamed(
                        AppRoutes.orderDetails.name,
                        pathParameters: {
                          'lang': context.locale.languageCode,
                          "goToInvoice" : "no",
                          "id": odoo == "no"
                              ? orderModel!.id.toString()
                              : orders['sales_order_id'].toString(),
                          "orderId": odoo == "no"
                              ? orderModel!.id.toString()
                              : orders['sales_order_id'].toString(),
                          "storeId": storeId.toString(),
                          "odoo": odoo,
                          "invoice" : "no"
                        },
                        queryParameters: {
                          'lang': context.locale.languageCode,
                        },
                        extra: begin,
                      );

                    }
                  }
                },
                borderSide:
                    const BorderSide(width: 1, color: Color(AppColors.oc1)),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: AppStrings.details.tr(),
                fontColor: const Color(AppColors.oc1),
                backgroundColor: Colors.transparent,
              ),
             if(invoice != "yes") Text(
                   odoo == "no" ?  (orderStatusApiKeys.containsValue(orderModel!.merchantStatus)
                        ? orderStatusMap[orderStatusApiKeys.entries
                            .firstWhere((value) =>
                                value.value == orderModel!.merchantStatus!)
                            .key]!.tr()
                        : orderModel!.merchantStatus) ??
                    '': orders['sales_status'].toString().tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color:invoice == "yes" ? const Color(0xFF2AA952): odoo == "no" ?(orderStatusApiKeys.containsValue(orderModel!.merchantStatus))?(orderStatusMap[orderStatusApiKeys.entries
                          .firstWhere((value) =>
                      value.value == orderModel!.merchantStatus!)
                          .key]!.tr().contains("متوفر") || orderStatusMap[orderStatusApiKeys.entries
                          .firstWhere((value) =>
                      value.value == orderModel!.merchantStatus!)
                          .key]!.tr().contains("available"))? Colors.red :const Color(0xFF2AA952) : Colors.transparent??Colors.transparent : const Color(0xFF2AA952) ,
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
   String? title;
   String? data;
  bool? status = false;
   TitleWithDataWidget(
      {super.key, this.title, this.data, this.status});

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
        if(status == false)Text(
          data!,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppThemeService.colorPalette.quaternaryTextColor.color,
              ),
        ),if(status == true)Text(
          data!,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: (data != null)?
                (data!.contains("متوفر") || data!.contains("available"))?Colors.red: const Color(0xFF2AA952)
            :Colors.transparent,
              ),
        ),
      ],
    );
  }
}
