import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/home/widget/product_calculate.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
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
          return Padding(
            padding:const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.selectIndex == 0) Text(
                  "${singleProductProvider.singleProductModel!.product!.description}",
                  style:const TextStyle(fontSize: 12,
                  color: Color(0xff1B1B1B),
                    fontWeight: FontWeight.w400
                  ),
                ),
                if(widget.selectIndex == 1) ProductCalculate()
              ],
            ),
          );
        }
    );
  }
}
