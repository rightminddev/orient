import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/models/availability/availability_model.dart';
import 'package:orient/utils/media_query_values.dart';
import 'package:provider/provider.dart';

import '../../../common_modules_widgets/loading_page.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../utils/components/general_components/button_widget.dart';
import '../../../utils/components/general_components/gradient_bg_image.dart';
import '../../../utils/components/general_components/product_container_with_text_field_widget.dart';
import '../view_models/stores.viewmodel.dart';

class AvailableProductsScreen extends StatefulWidget {
  final int storeId;
  const AvailableProductsScreen({super.key, required this.storeId});

  @override
  State<AvailableProductsScreen> createState() =>
      _AvailableProductsScreenState();
}

class _AvailableProductsScreenState extends State<AvailableProductsScreen> {
  final ScrollController controller = ScrollController();
  late final StoresViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = StoresViewModel();
    viewModel.initializeAvailableProductsScreen(context, widget.storeId);
  }

  @override
  void dispose() {
    controller.dispose();
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
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: ShapeDecoration(
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
                onPressed: () {
                  viewModel.updateAvailableProducts(context, widget.storeId);
                },
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s48, vertical: AppSizes.s16),
                title: "Update",
                svgIcon: AppIcons.checkMarkDashed,
              ),
            ],
          ),
        ),
        title: AppStrings.availabilityOfProducts.tr(),
        body: Consumer<StoresViewModel>(
          builder: (context, viewModel, child) => viewModel.isLoading
              ? const LoadingPageWidget(
                  reverse: true,
                  height: AppSizes.s75,
                )
              : GradientBgImage(
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: context.viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 18),
                          ...viewModel.products.map((element) {
                            return ProductContainerWithTextFieldWidget(
                              onQuantitySubmitted: (value) {
                                final index = viewModel.addedToStock.products!
                                    .indexWhere(
                                        (e) => e.productId == element.id);
                                if (index == -1) {
                                  viewModel.addedToStock.products!
                                      .add(AddedProductsModel(
                                    productId: element.id,
                                    quantity: int.parse(value),
                                  ));
                                }
                              },
                              stock: element.stock,
                              title: element.title,
                              price: (element.merchantsPrice ?? 0).toString(),
                              unit: element.merchantsUnit,
                              imageUrl:
                                  element.mainCover?.elementAt(0).thumbnail,
                            );
                          }),
                          SizedBox(height: 64),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
