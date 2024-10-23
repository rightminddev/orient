import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/common_modules_widgets/template_page.widget.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../utils/components/general_components/all_bottom_sheet.dart';
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

  const OrderDetailsScreen(
      {super.key, required this.storeId, required this.orderId});

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
    viewModel.initializeOrderDetailsScreen(
        context, widget.storeId, widget.orderId);
  }

  @override
  void dispose() {
    controller.dispose();
    orderStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrdersViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
        backgroundColor: Colors.white,
        pageContext: context,
        bottomSheet: Container(
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
                onPressed: () async {
                  await orderStatusActionBottomSheet(
                    context: context,
                    buttonText: AppStrings.changes.tr(),
                    orderActionsViewModel: orderActionsViewModel,
                    dropDownTitle: AppStrings.status.tr(),
                    onItemTap: (value) {
                      orderActionsViewModel.orderStatus =
                          orderStatusApiKeys[value];
                    },
                    dropDownOnChanged: (value) {
                      // orderActionsViewModel.orderStatus =
                      //     orderStatusApiKeys[index];
                    },
                    onTapButton: () {
                      if (orderActionsViewModel.orderStatus != null) {
                        orderActionsViewModel
                            .updateOrderStatus(
                                context, widget.orderId, widget.storeId)
                            .then(
                          (value) {
                            if (value == true) {
                              viewModel.orderDetails.status =
                                  orderStatusMap[orderStatus.value];
                            }
                          },
                        );
                      }
                    },
                  );
                },
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: AppStrings.actions.tr(),
                svgIcon: AppIcons.info,
              ),
            ],
          ),
        ),
        onRefresh: () async => await viewModel.initializeOrderDetailsScreen(
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
                          '${AppStrings.orderNo.tr()} ${viewModel.orderDetails.uuid}',
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
                          data: viewModel.orderDetails.date ?? '',
                          title: AppStrings.date.tr(),
                        ),
                        const SizedBox(height: 12),
                        TitleWithDataWidget(
                          data:
                              '${viewModel.orderDetails.total} EGP', //TODO: currency
                          title: AppStrings.totalAmount.tr(),
                        ),
                        const SizedBox(height: 12),
                        TitleWithDataWidget(
                          data: (orderStatusApiKeys.containsValue(
                                      viewModel.orderDetails.merchantStatus)
                                  ? orderStatusMap[orderStatusApiKeys.entries
                                      .firstWhere((value) =>
                                          value.value ==
                                          viewModel.orderDetails.merchantStatus)
                                      .key]
                                  : viewModel.orderDetails.merchantStatus) ??
                              '',
                          title: AppStrings.status.tr(),
                        ),
                        // TrackingOrderTextWidget(
                        //   textOnLeft: viewModel.orderDetails.uuid ?? '',
                        //   textOnRight: viewModel.orderDetails.status ?? '',
                        // ),
                        const SizedBox(height: 12),
                        ...(viewModel.orderDetails.items ?? [])
                            .asMap()
                            .map((index, element) {
                          return MapEntry(
                            index,
                            Column(
                              children: [
                                defaultProductContainer(
                                    context: context,
                                    showBookMark: false,
                                    title: element.title,
                                    imageUrl: element.image?.elementAt(0).file,
                                    price: element.priceAfterDiscount != null
                                        ? '${element.priceAfterDiscount} EGP'
                                        : '${element.price} EGP',
                                    unit:
                                        '${AppStrings.units.tr()}: ${element.quantity}',
                                    showDiscountPrice:
                                        element.priceAfterDiscount != null
                                            ? true
                                            : false,
                                    discountPrice:
                                        '${element.priceAfterDiscount} EGP'),
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
                          textOnRight:
                              viewModel.orderDetails.customerName ?? '',
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
                          textOnRight: (viewModel.orderDetails.customerId ?? 0)
                              .toString(),
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
                          textOnRight: '${viewModel.orderDetails.total} EGP',
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
