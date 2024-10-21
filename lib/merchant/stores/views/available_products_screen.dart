import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/utils/media_query_values.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../models/products/add_product_model.dart';
import '../../../models/request/request_model.dart';
import '../../../utils/components/general_components/all_text_field.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
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

  late final StoresViewModel viewModel;
  late final StoreActionsViewModel storeActionsViewModel;
  List<AddedProductsModel> orders = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    viewModel = StoresViewModel();
    storeActionsViewModel = StoreActionsViewModel();
    viewModel.initializeAvailableProductsScreen(context, widget.storeId);
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoresViewModel>(
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
          // child: Consumer<StoreActionsViewModel>(
          //   builder: (context, viewModel, child) {
          child: ChangeNotifierProvider(
            create: (_) => storeActionsViewModel,
            child: Consumer<StoreActionsViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonWidget(
                      onPressed: () {
                        if (widget.isInAvailable == true) {
                          storeActionsViewModel.updateAvailableProducts(
                              context, widget.storeId);
                        } else {
                          storeActionsViewModel.calculateOrders(
                              context, storeActionsViewModel, widget.storeId);
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
        body: Consumer<StoresViewModel>(
          builder: (context, viewModel, child) => viewModel.isLoading
              ? const LoadingPageWidget(
                  reverse: true,
                  height: AppSizes.s75,
                )
              : GradientBgImage(
                  // padding: EdgeInsets.only(
                  //   bottom: context.viewInsets.bottom,
                  //   left: 8,
                  //   right: 8,
                  // ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //  const SizedBox(height: 18),
                        defaultTextFormField(
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
                            viewModel.search = value;
                            viewModel.initializeAvailableProductsScreen(
                                context, widget.storeId);
                          },
                        ),
                        ...viewModel.products.asMap().map((index, element) {
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
                                    storeActionsViewModel.requestedOrders.items!
                                        .add(AddedProductsModel(
                                      productId: element.id,
                                      quantity: int.parse(value),
                                    ));
                                    orders.add(AddedProductsModel(
                                      productId: element.id,
                                      quantity: int.parse(value),
                                    ));
                                  } else {
                                    storeActionsViewModel.requestedOrders.items!
                                        .elementAt(index)
                                        .quantity = int.parse(value);
                                    orders.elementAt(index).quantity =
                                        int.parse(value);
                                  }
                                }
                              },
                              stock: orders.elementAtOrNull(index)?.productId ==
                                      element.id
                                  ? orders.elementAt(index).quantity
                                  : widget.isInAvailable == true
                                      ? element.stock
                                      : 0,
                              title: element.title,
                              price: (element.merchantsPrice ?? 0).toString(),
                              unit: element.merchantsUnit,
                              imageUrl:
                                  element.mainCover?.elementAt(0).thumbnail,
                            ),
                          );
                        }).values,
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
