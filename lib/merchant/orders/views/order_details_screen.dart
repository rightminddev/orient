import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/common_modules_widgets/template_page.widget.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../utils/components/general_components/all_bottom_sheet.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../../../utils/components/general_components/general_components.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/text_with_space_between.dart';
import '../models/order_status.dart';
import '../view_models/orders.actions.viewmodel.dart';
import '../view_models/orders.viewmodel.dart';

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
                  await defaultActionBottomSheet(
                    context: context,
                    buttonText: AppStrings.changes.tr(),
                    viewCheckIcon: false,
                    viewDropDownButton: true,
                    dropDownValue: orderActionsViewModel.orderStatus,
                    dropDownTitle: AppStrings.status.tr(),
                    dropDownItems: orderStatusMap
                        .map(
                          (index, element) => MapEntry(
                            index,
                            DropdownMenuItem<String>(
                              onTap: () {
                                orderActionsViewModel.orderStatus =
                                    orderStatusApiKeys[index];
                              },
                              value: element,
                              child: Text(
                                element,
                                style: const TextStyle(
                                  color: Color(0xFF464646),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.11,
                                ),
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                    dropDownOnChanged: (value) {
                      // orderActionsViewModel.orderStatus =
                      //     orderStatusApiKeys[index];
                    },
                    onTapButton: () {
                      if (orderActionsViewModel.orderStatus != null) {
                        orderActionsViewModel.updateOrderStatus(
                            context, widget.orderId, widget.storeId);
                      }
                    },
                  );
                },
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "Actions",
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
                ? const LoadingPageWidget(
                    reverse: true,
                    height: AppSizes.s75,
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        TextWithSpaceBetween(
                          textOnLeft: 'ORDER № ${viewModel.orderDetails.uuid}',
                          textOnRight: viewModel.orderDetails.date ?? '',
                        ),
                        const SizedBox(height: 12),
                        TrackingOrderTextWidget(
                          textOnLeft: viewModel.orderDetails.uuid ?? '',
                          textOnRight: viewModel.orderDetails.status ?? '',
                        ),
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
                                    unit: 'UNITS: ${element.quantity}',
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
                          textOnLeft: AppStrings.totalAmount.tr(),
                          textOnLeftFontColor: AppThemeService
                              .colorPalette.quaternaryTextColor.color,
                          textOnLeftFontSize: 14,
                          textOnLeftFontWeight: FontWeight.w400,
                          textOnRightFontColor: AppThemeService
                              .colorPalette.tertiaryTextColor.color,
                          textOnRightFontSize: 14,
                          textOnRight:
                              (viewModel.orderDetails.total ?? 0).toString(),
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
