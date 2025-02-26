import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/common_modules_widgets/template_page.widget.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/merchant/orders/views/order.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../../../utils/components/general_components/general_components.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/order_container_widget.dart';
import '../../../utils/components/general_components/text_with_space_between.dart';
import '../models/order_status.dart';
import '../view_models/orders.actions.viewmodel.dart';
import '../view_models/orders.viewmodel.dart';
import '../widgets/order_details_loading_page.widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int storeId;
  final int orderId;
  final String odoo;
  const OrderDetailsScreen(
      {super.key, required this.storeId, required this.orderId, required this.odoo});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final ScrollController controller = ScrollController();
  late final OrdersViewModel viewModel;
  late final OrderActionsViewModel orderActionsViewModel;
  late final ValueNotifier<OrderStatus?> orderStatus =
      ValueNotifier<OrderStatus?>(null);

  @override
  void initState() {
    super.initState();
    viewModel = OrdersViewModel();
    orderActionsViewModel = OrderActionsViewModel();
    if(widget.odoo == "no"){  viewModel.initializeOrderDetailsScreen(
        context, widget.storeId, widget.orderId);}
    if(widget.odoo == "yes"){  viewModel.initializeOrderOdooDetailsScreen(
        context, widget.storeId, widget.orderId);}
   }

  @override
  Widget build(BuildContext context) {
    var gCache;
    final jsonString = CacheHelper.getString("USG");
    if (jsonString != null) {
      gCache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
      print("USG IS --> $gCache");
    }
    if(orderActionsViewModel.isUpdate == true){
      print("YAH TRUE");
    }
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> viewModel),
      ChangeNotifierProvider(create: (_)=> orderActionsViewModel),
    ],
    child: TemplatePage(
      backgroundColor: Colors.white,
      pageContext: context,
      bottomSheet: widget.odoo != "yes" ?Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 11,
              offset: Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
              isLoading: false,
              onPressed: () async {
                await showModalBottomSheet(
                context: context!,
                shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (BuildContext context) {
                return OrderDropDownWidget(
                    widget.storeId, widget.orderId
                );
                },
                );
                 WidgetsBinding.instance.addPostFrameCallback((_) {
                   if (context.mounted) {
                     if(widget.odoo == "no"){  viewModel.initializeOrderDetailsScreen(
                         context, widget.storeId, widget.orderId);}
                     if(widget.odoo == "yes"){  viewModel.initializeOrderOdooDetailsScreen(
                         context, widget.storeId, widget.orderId);}
                   }
                 });
                // await orderStatusActionBottomSheet(
                //   context: context,
                //   buttonText: AppStrings.changes.tr(),
                //   orderActionsViewModel: orderActionsViewModel,
                //   dropDownTitle: AppStrings.status.tr(),
                //   onItemTap: (value) {
                //     orderActionsViewModel.orderStatus =
                //     orderStatusApiKeys[value];
                //   },
                //   dropDownOnChanged: (value) {
                //     // orderActionsViewModel.orderStatus =
                //     //     orderStatusApiKeys[index];
                //   },
                //   onTapButton: () {
                //     if (orderActionsViewModel.orderStatus != null) {
                //       orderActionsViewModel
                //           .updateOrderStatus(
                //           context, widget.orderId, widget.storeId)
                //           .then(
                //             (value) {
                //           if (value == true) {
                //             viewModel.orderDetails.status =
                //             orderStatusMap[orderStatus.value];
                //           }
                //         },
                //       );
                //     }
                //   },
                // );
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    if(widget.odoo == "no"){  viewModel.initializeOrderDetailsScreen(
                        context, widget.storeId, widget.orderId);}
                    if(widget.odoo == "yes"){  viewModel.initializeOrderOdooDetailsScreen(
                        context, widget.storeId, widget.orderId);}
                  }
                });
                // Navigator.pop(context);
              },
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.s48, vertical: AppSizes.s16),
              title: AppStrings.actions.tr(),
              svgIcon: AppIcons.info,
            ),
            // ButtonWidget(
            //   isLoading: false,
            //   onPressed: () async {
            //
            //     // await orderStatusActionBottomSheet(
            //     //   context: context,
            //     //   buttonText: AppStrings.changes.tr(),
            //     //   orderActionsViewModel: orderActionsViewModel,
            //     //   dropDownTitle: AppStrings.status.tr(),
            //     //   onItemTap: (value) {
            //     //     orderActionsViewModel.orderStatus =
            //     //     orderStatusApiKeys[value];
            //     //   },
            //     //   dropDownOnChanged: (value) {
            //     //     // orderActionsViewModel.orderStatus =
            //     //     //     orderStatusApiKeys[index];
            //     //   },
            //     //   onTapButton: () {
            //     //     if (orderActionsViewModel.orderStatus != null) {
            //     //       orderActionsViewModel
            //     //           .updateOrderStatus(
            //     //           context, widget.orderId, widget.storeId)
            //     //           .then(
            //     //             (value) {
            //     //           if (value == true) {
            //     //             viewModel.orderDetails.status =
            //     //             orderStatusMap[orderStatus.value];
            //     //           }
            //     //         },
            //     //       );
            //     //     }
            //     //   },
            //     // );
            //     WidgetsBinding.instance.addPostFrameCallback((_) {
            //       if (context.mounted) {
            //         viewModel.initializeOrderDetailsScreen(
            //             context, widget.storeId, widget.orderId);
            //       }
            //     });
            //
            //   },
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: AppSizes.s48, vertical: AppSizes.s16),
            //   title: AppStrings.actions.tr(),
            //   svgIcon: AppIcons.info,
            // ),
          ],
        ),
      ) : null,
      onRefresh: () async =>(widget.odoo == "no")? await viewModel.initializeOrderDetailsScreen(
          context, widget.storeId, widget.orderId):await viewModel.initializeOrderOdooDetailsScreen(
          context, widget.storeId, widget.orderId),
      title: AppStrings.orderDetails.tr(),
      body: GradientBgImage(
        child: Consumer<OrdersViewModel>(
          builder: (context, viewModel, child) => viewModel.isLoading
              ? const OrderDetailsLoadingPage(
            height: AppSizes.s75,
          )
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                Text(
                  widget.odoo == "no" ?'${AppStrings.orderNo.tr()} ${viewModel.orderDetails.uuid}':'${AppStrings.orderNo.tr()} ${viewModel.odooOrderDetailsModel!.order!.salesOrderName}',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(
                    color: AppThemeService
                        .colorPalette.secondaryTextColor.color,
                    height: 0,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 12),
                TitleWithDataWidget(
                  status: false,
                  data:widget.odoo == "no" ? viewModel.orderDetails.date ?? '' : viewModel.odooOrderDetailsModel!.order!.salesOrderDateOnly ?? '',
                  title: AppStrings.date.tr(),
                ),
                const SizedBox(height: 12),
                TitleWithDataWidget(
                  status: false,
                  data:widget.odoo == "no" ? '${viewModel.orderDetails.total} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}': '${viewModel.odooOrderDetailsModel!.order!.salesOrderAmount} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}',
                  title: AppStrings.totalAmount.tr(),
                ),
                const SizedBox(height: 12),
                TitleWithDataWidget(
                  status: true,
                  data: widget.odoo == "no" ? (viewModel.orderDetails.merchantStatus != null)? (orderStatusApiKeys.containsValue(viewModel.orderDetails.status!.tr())
                      ? orderStatusMap[orderStatusApiKeys.entries.firstWhere((value) => value.value == viewModel.orderDetails.merchantStatus).key]!.tr()
                      : viewModel.orderDetails.merchantStatus!.tr()) : "" : viewModel.odooOrderDetailsModel!.order!.salesStatus!.toString().tr(),
                  title: AppStrings.status.tr(),
                ),
                // TrackingOrderTextWidget(
                //   textOnLeft: viewModel.orderDetails.uuid ?? '',
                //   textOnRight: viewModel.orderDetails.status ?? '',
                // ),
                const SizedBox(height: 12),
               if(widget.odoo == "no" ) ...(viewModel.orderDetails.items ?? [])
                    .asMap()
                    .map((index, element) {
                  return MapEntry(
                    index,
                    Column(
                      children: [
                        defaultProductContainer(
                            context: context,
                            max: 3,
                            showBookMark: false,
                            title: element.title,
                            imageUrl:
                            (element.image?.elementAt(0) != null)
                                ? element.image?.elementAt(0).file
                                : "",
                            price: element.priceAfterDiscount != null
                                ? '${element.priceAfterDiscount} ${gCache['default_currency']['code']}'
                                : '${element.price} ${gCache['default_currency']['code']}',
                            unit: '${AppStrings.units.tr()}: ${element.quantity}',
                            showDiscountPrice:
                            element.priceAfterDiscount != null
                                ? true
                                : false,
                            discountPrice:
                            '${element.priceAfterDiscount} ${gCache['default_currency']['code']}'),
                        index !=
                            (viewModel.orderDetails.items!.length -
                                1)
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16),
                          child: Divider(
                            thickness: 2,
                            color: AppThemeService
                                .colorPalette.tertiaryColor.color,
                          ),
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                }).values,
                if(widget.odoo == "yes" ) ...(viewModel.odooOrderDetailsModel!.order!.salesOrderDetails ?? [])
                    .asMap()
                    .map((index, element) {
                  return MapEntry(
                    index,
                    Column(
                      children: [
                        defaultProductContainer(
                            context: context,
                            max: 3,
                            showBookMark: false,
                            title: element.productName.toString(),
                            imageUrl:
                            (element.mainCover != null && element.mainCover!.isNotEmpty)
                                ? element.mainCover![0].file
                                : "",
                            price: element.productPriceTotal != null
                                ? '${element.productPriceTotal} ${gCache['default_currency']['code']}'
                                : '${element.productPrice} ${gCache['default_currency']['code']}',
                            showUnit: (element.unitOfMeasureName != false)? true : false,
                            unit: (element.unitOfMeasureName != false)?
                            '${element.unitOfMeasureName}: ${element.productQty}' : null,
                            showDiscountPrice:
                            element.productDiscount != 0
                                ? true
                                : false,
                            discountPrice:
                            '${element.productDiscount} ${gCache['default_currency']['code']}'),
                        index != (viewModel.odooOrderDetailsModel!.order!.salesOrderDetails!.length -
                                1)
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xff464646).withOpacity(0.5),
                          ),
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                }).values,
                const SizedBox(height: 12),
                Text(
                  AppStrings.orderInformation.tr(),
                  style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppThemeService
                        .colorPalette.secondaryTextColor.color,
                    height: 0,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 12),
                TextWithSpaceBetween(
                  textOnLeft: AppStrings.customerName.tr(),
                  textOnLeftFontColor: AppThemeService
                      .colorPalette.quaternaryTextColor.color,
                  textOnLeftFontSize: 14,
                  textOnLeftFontWeight: FontWeight.w400,
                  textOnRightFontColor: AppThemeService
                      .colorPalette.tertiaryTextColor.color,
                  textOnRightFontSize: 14,
                  textOnRight: widget.odoo == "no" ?viewModel.orderDetails.customerName ?? '':viewModel.odooOrderDetailsModel!.order!.clientName ?? '',
                ),
                const SizedBox(height: 12),
                TextWithSpaceBetween(
                  textOnLeft: AppStrings.customerId.tr(),
                  textOnLeftFontColor: AppThemeService
                      .colorPalette.quaternaryTextColor.color,
                  textOnLeftFontSize: 14,
                  textOnLeftFontWeight: FontWeight.w400,
                  textOnRightFontColor: AppThemeService
                      .colorPalette.tertiaryTextColor.color,
                  textOnRightFontSize: 14,
                  textOnRight:widget.odoo == "no" ? (viewModel.orderDetails.customerId ?? 0).toString():(viewModel.odooOrderDetailsModel!.order!.clientId ?? 0).toString(),
                ),
                const SizedBox(height: 12),
                TextWithSpaceBetween(
                  textOnLeft: AppStrings.totalAmount.tr(),
                  textOnLeftFontColor: AppThemeService
                      .colorPalette.quaternaryTextColor.color,
                  textOnLeftFontSize: 14,
                  textOnLeftFontWeight: FontWeight.w400,
                  textOnRightFontColor: AppThemeService
                      .colorPalette.tertiaryTextColor.color,
                  textOnRightFontSize: 14,
                  textOnRight: widget.odoo == "no" ?'${viewModel.orderDetails.total} ${gCache['default_currency']['code']}':'${viewModel.odooOrderDetailsModel!.order!.salesOrderAmount} ${gCache['default_currency']['code']}',
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
