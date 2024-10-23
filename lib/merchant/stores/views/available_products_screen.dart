import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../models/products/add_product_model.dart';
import '../../../utils/components/general_components/all_text_field.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../../../utils/components/general_components/pagination_widget.dart';
import '../../../utils/components/general_components/product_container_with_text_field_widget.dart';
import '../view_models/stores.actions.viewmodel.dart';
import '../view_models/stores.viewmodel.dart';

class AvailableProductsScreen extends StatefulWidget {
  final bool isInAvailable;
  final int storeId;
  const AvailableProductsScreen({
    super.key,
    required this.storeId,
    this.isInAvailable = true,
  });

  @override
  State<AvailableProductsScreen> createState() =>
      _AvailableProductsScreenState();
}

class _AvailableProductsScreenState extends State<AvailableProductsScreen> {
  final ScrollController controller = ScrollController();
  final TextEditingController searchController = TextEditingController();

  late final StoresViewModel storesViewModel;
  late final StoreActionsViewModel storeActionsViewModel;
  List<AddedProductsModel> orders = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    storesViewModel = StoresViewModel();
    storeActionsViewModel = StoreActionsViewModel();
    storesViewModel.initializeAvailableProductsScreen(context, widget.storeId);
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    if (!context.mounted) {
      storesViewModel.dispose();
      storeActionsViewModel.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoresViewModel>.value(
      value: storesViewModel,
      child: Consumer<StoresViewModel>(
        builder: (context, viewModel, child) => TemplatePage(
          backgroundColor: Colors.white,
          pageContext: context,
          // onRefresh: () async {
          //   storesViewModel.pageNumber = 1;

          //   storesViewModel.products = List.empty(growable: true);
          //   storesViewModel.initializeAvailableProductsScreen(
          //       context, widget.storeId);
          // },

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
            // child: Consumer<StoreActionsViewModel>(
            //   builder: (context, viewModel, child) {
            child: ChangeNotifierProvider.value(
              value: storeActionsViewModel,
              child: Consumer<StoreActionsViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonWidget(
                        onPressed: () {
                          if (widget.isInAvailable == true) {
                            viewModel.updateAvailableProducts(
                                context, widget.storeId);
                          } else {
                            viewModel.calculateOrders(
                                context, viewModel, widget.storeId);
                          }
                        },
                        isLoading: viewModel.isLoading,
                        // isLoading: viewModel.isLoading,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s48, vertical: AppSizes.s16),
                        title: widget.isInAvailable == true
                            ? AppStrings.update.tr()
                            : AppStrings.calculateThePrice.tr(),
                        svgIcon: AppIcons.checkMarkDashed,
                      ),
                    ],
                  );
                },
              ),
            ),
            //   },
            // ),
          ),

          title: widget.isInAvailable == true
              ? AppStrings.availabilityOfProducts.tr()
              : AppStrings.addRequest.tr(),
          body: GradientBgImage(
            child: Column(
              children: [
                //       const SizedBox(height: 24),
                //  const SizedBox(height: 18),
                defaultTextFormField(
                  hasShadows: false,
                  controller: searchController,
                  hintText: AppStrings.search.tr(),
                  textInputAction: TextInputAction.search,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(AppColors.oc2),
                  ),
                  // validator: (value) {

                  // },
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) {
                    storesViewModel.search = value;

                    storesViewModel.initializeAvailableProductsScreen(
                        context, widget.storeId);
                  },
                ),
                const SizedBox(height: 18),
                PaginationWidget(
                  currentCount: storesViewModel.pageNumber,
                  isLoading: storesViewModel.isLoading,
                  firstFetch: () {
                    storesViewModel.pageNumber = 1;

                    storesViewModel.products = List.empty(growable: true);
                    storesViewModel.initializeAvailableProductsScreen(
                        context, widget.storeId);
                  },
                  scrollController: controller,
                  paginationFetch: () {
                    final hasMoreData = storesViewModel
                        .hasMoreData(storesViewModel.products.length);
                    if (hasMoreData) {
                      //      storesViewModel.pageNumber = storesViewModel.pageNumber + 1;

                      storesViewModel.initializeAvailableProductsScreen(
                          context, widget.storeId);
                    } else {}
                  },
                  scrollableWidget: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: storesViewModel.products
                          .asMap()
                          .map((index, element) {
                            final isOrderUpdatedIndex = orders.indexWhere(
                                (order) => order.productId == element.id);
                            int? quantity = isOrderUpdatedIndex >= 0
                                ? orders
                                    .elementAtOrNull(isOrderUpdatedIndex)
                                    ?.quantity
                                : null;
                            return MapEntry(
                              index,
                              ProductContainerWithTextFieldWidget(
                                onQuantitySubmitted: (value) {
                                  if (widget.isInAvailable == true) {
                                    final index = storeActionsViewModel
                                        .addedToStock.items!
                                        .indexWhere(
                                            (e) => e.productId == element.id);
                                    if (index == -1) {
                                      storeActionsViewModel.addedToStock.items!
                                          .add(AddedProductsModel(
                                        productId: element.id,
                                        quantity: int.parse(value),
                                      ));
                                      orders.add(AddedProductsModel(
                                        productId: element.id,
                                        quantity: int.parse(value),
                                      ));
                                    } else {
                                      storeActionsViewModel.addedToStock.items!
                                          .elementAt(index)
                                          .quantity = int.parse(value);
                                      orders.elementAt(index).quantity =
                                          int.parse(value);
                                    }
                                  } else {
                                    final index = storeActionsViewModel
                                        .requestedOrders.items!
                                        .indexWhere(
                                            (e) => e.productId == element.id);
                                    if (index == -1) {
                                      storeActionsViewModel
                                          .requestedOrders.items!
                                          .add(AddedProductsModel(
                                        productId: element.id,
                                        quantity: int.parse(value),
                                      ));
                                      orders.add(AddedProductsModel(
                                        productId: element.id,
                                        quantity: int.parse(value),
                                      ));
                                    } else {
                                      storeActionsViewModel
                                          .requestedOrders.items!
                                          .elementAt(index)
                                          .quantity = int.parse(value);
                                      orders.elementAt(index).quantity =
                                          int.parse(value);
                                    }
                                  }
                                },
                                stock: quantity ??
                                    (widget.isInAvailable == true
                                        ? element.stock
                                        : 0),
                                // orders.elementAtOrNull(index)?.productId ==
                                //         element.id
                                //     ? orders.elementAt(index).quantity
                                //     : widget.isInAvailable == true
                                //         ? element.stock
                                //         : 0,
                                title: element.title,
                                price: (element.merchantsPrice ?? 0).toString(),
                                unit: element.merchantsUnit,
                                imageUrl: element.mainCover != null &&
                                        element.mainCover!.isNotEmpty
                                    ? element.mainCover?.elementAt(0).thumbnail
                                    : '',
                              ),
                            );
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
