import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_bottom_button_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_change_count_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_comment_bottomsheet_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_description_tapbar_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_details_and_colors_widget.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_sizes_widget.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class EcommerceSingleProductDetailScreen extends StatefulWidget {
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
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(toolbarHeight: 0.0),
        body: GradientBgImage(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/ecommerce/png/product.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SingleDetailsAndColorsWidget(),
                        const SizedBox(height: 16),
                        SingleSizesWidget(),
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
                                return await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                                  ),
                                  builder: (BuildContext context) {
                                    return const SingleCommentBottomsheetWidget();
                                  },
                                );
                              }
                              setState(() {
                                selectIndex = index;
                              });
                              print(selectIndex);
                            })
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if(selectIndex == 0)const SingleDescriptionTapbarWidget()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SingleBottomButtonWidget()
    );
  }
}
