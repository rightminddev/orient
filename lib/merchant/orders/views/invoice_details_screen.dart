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

class InvoiceDetailsScreen extends StatefulWidget {
  final int storeId;
  final int orderId;
  final int invoiceId;
  final String odoo;
  const InvoiceDetailsScreen(
      {super.key, required this.storeId, required this.orderId, required this.odoo, required this.invoiceId});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
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
    viewModel.initializeInvoiceDetailsScreen(
        context, widget.storeId, widget.orderId, widget.invoiceId);
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
        onRefresh: () async => viewModel.initializeInvoiceDetailsScreen(
            context, widget.storeId, widget.orderId, widget.invoiceId),
        title: AppStrings.invoiceDetails.tr(),
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
                   '${AppStrings.orderNo.tr()} ${viewModel.invoiceDetailsModel!.invoice!.invoiceName}',
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
                    data: viewModel.invoiceDetailsModel!.invoice!.invoiceDateOnly,
                    title: AppStrings.date.tr(),
                  ),
                  const SizedBox(height: 12),
                  TitleWithDataWidget(
                    status: false,
                    data: '${viewModel.invoiceDetailsModel!.invoice!.invoiceAmount.toString()} ${gCache['default_currency']['code']}',
                    title: AppStrings.totalAmount.tr(),
                  ),
                  const SizedBox(height: 12),
                  // TitleWithDataWidget(
                  //   status: true,
                  //   data:  viewModel.invoiceDetailsModel!.invoice!.invoiceStatus!.tr(),
                  //   title: AppStrings.status.tr(),
                  // ),
                  // TrackingOrderTextWidget(
                  //   textOnLeft: viewModel.orderDetails.uuid ?? '',
                  //   textOnRight: viewModel.orderDetails.status ?? '',
                  // ),
                  const SizedBox(height: 12),
                ...(viewModel.invoiceDetailsModel!.invoice!.invoiceDetails ?? [])
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
                              title: element.productName,
                              imageUrl: (element.productImgLink != null && element.productImgLink != "")?element.productImgLink:
                              (element.mainCover != null && element.mainCover!.isNotEmpty)
                                  ? element.mainCover![0].file
                                  : "",
                              price: element.productPriceTotal != null
                                  ? '${element.productPriceTotal} ${gCache['default_currency']['code']}'
                                  : '${element.productPrice} ${gCache['default_currency']['code']}',
                              unit: '${AppStrings.units.tr()}: ${element.productQty}',
                              showDiscountPrice:
                              element.productDiscount != 0
                                  ? true
                                  : false,
                              discountPrice:
                              '${element.productDiscount} ${gCache['default_currency']['code']}'),
                          index != (viewModel.invoiceDetailsModel!.invoice!.invoiceDetails!.length -
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
                    textOnRight: viewModel.invoiceDetailsModel!.invoice!.clientName ?? '',
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
                    textOnRight: viewModel.invoiceDetailsModel!.invoice!.clientId.toString() ?? "0",
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
                    textOnRight: '${viewModel.invoiceDetailsModel!.invoice!.invoiceAmount} ${gCache['default_currency']['code']}',
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
