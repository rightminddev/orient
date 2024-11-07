import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:orient/modules/ecommerce/single_product/single_producr_screen_loading.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_bottom_button_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_change_count_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_description_tapbar_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_details_and_colors_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_sizes_widget.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class EcommerceSingleProductDetailScreen extends StatefulWidget {
  final int id;
  EcommerceSingleProductDetailScreen(@required this.id);
  @override
  State<EcommerceSingleProductDetailScreen> createState() => _EcommerceSingleProductDetailScreenState();
}

class _EcommerceSingleProductDetailScreenState extends State<EcommerceSingleProductDetailScreen> {
  int selectIndex = 0;
  List<String> tapBarItems = [
    AppStrings.description.tr(),
    AppStrings.calc.tr(),
    AppStrings.techPdf.tr(),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> SingleProductProvider()..getOneProduct(context: context, id: widget.id, crossSells: true),
    child: Consumer<SingleProductProvider>(
      builder: (context, singleProductProvider, child){
        print("PRODUCT ID IS ------> ${widget.id}");
        return (singleProductProvider.singleProductModel == null)?
        const SingleProductScreenLoading()
        :SafeArea(
          child: Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              body: GradientBgImage(
                padding: EdgeInsets.zero,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        height: 350,
                        width: double.infinity,
                        imageUrl:(singleProductProvider.singleProductModel!.product!.mainCover!.isNotEmpty)? "${singleProductProvider.singleProductModel!.product!.mainCover![0].file}" : "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ShimmerAnimatedLoading(
                          circularRaduis: AppSizes.s50,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: AppSizes.s32,
                          color: Colors.white,
                        ),
                      ),
                     const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SingleDetailsAndColorsWidget(widget.id),
                            const SizedBox(height: 16),
                            SingleSizesWidget(viewSize: true, id: widget.id,),
                            const SizedBox(height: 16),
                            const SingleChangeCountWidget(),
                            const SizedBox(
                              height: 30,
                            ),
                            defaultTapBarItem(
                                items: tapBarItems,
                                selectIndex: selectIndex,
                                onTapItem: (index) async{
                                  if(index == 1){
                                  }
                                  setState(() {
                                    selectIndex = index;
                                  });
                                  print(selectIndex);
                                })
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      SingleDescriptionTapbarWidget(selectIndex : selectIndex, description: "${singleProductProvider.singleProductModel!.product!.description}",),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
              bottomNavigationBar:(singleProductProvider.singleProductModel == null)?Container(height: 136,) :
              SingleBottomButtonWidget(totalPrice: "${singleProductProvider.singleProductModel!.product!.price}",id: singleProductProvider.singleProductModel!.product!.id)
          ),
        );
      },
    ),
    );
  }
}
