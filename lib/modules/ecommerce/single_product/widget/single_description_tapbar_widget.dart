import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/modules/ecommerce/home/widget/product_calculate.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:orient/utils/styles.dart';
import 'package:provider/provider.dart';

class SingleDescriptionTapbarWidget extends StatefulWidget {
  int selectIndex;
  String? description;

   SingleDescriptionTapbarWidget({required this.selectIndex, this.description});

  @override
  State<SingleDescriptionTapbarWidget> createState() => _SingleDescriptionTapbarWidgetState();
}

class _SingleDescriptionTapbarWidgetState extends State<SingleDescriptionTapbarWidget> {
  String? selectCategory;

var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductProvider>(
        builder: (context, singleProductProvider, child){
          bool containsHtmlTags(String text) {
            final regex = RegExp(r'<[^>]*>'); // Regex to detect HTML tags
            return regex.hasMatch(text);
          }
          return Padding(
            padding:const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  if(widget.selectIndex == 0)Html(
                    shrinkWrap: true,
                    data: singleProductProvider.singleProductModel!.product!.description ?? '',
                    style: containsHtmlTags(singleProductProvider.singleProductModel!.product!.description ?? '')
                        ? TextsStyles.htmlStyle
                        : {
                      "body": Style(
                        color: Color(0xff525252),
                        lineHeight: LineHeight(1.5),
                        fontSize: FontSize(14), // Adjust font size for better visibility
                        fontWeight: FontWeight.w400,
                      ),
                    },
                  ),
                if(widget.selectIndex == 1 && singleProductProvider.singleProductModel!.product!.per_meter_value != null && singleProductProvider.singleProductModel!.product!.per_meter_unit != null) ProductCalculate(single: true, id: singleProductProvider.singleProductModel!.product!.id ,)
              ],
            ),
          );
        }
    );
  }
}
