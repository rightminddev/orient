import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/single_product/controller/const.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:orient/modules/ecommerce/single_product/widget/single_comment_bottomsheet_widget.dart';
import 'package:provider/provider.dart';

class SingleDetailsAndColorsWidget extends StatelessWidget {
  int? id;
  SingleDetailsAndColorsWidget(@required this.id);

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductProvider>(
        builder: (context, singleProductProvider, child){
          return Column(
            children: [
              Text(
                singleProductProvider.productName!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff0D3B6F),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Color(0xffE6007E), size: 20,),
                  const SizedBox(width: 5),
                  Text("${(singleProductProvider.singleProductModel!.product!.reviewRate != null)?singleProductProvider.singleProductModel!.product!.reviewRate :0} (${(singleProductProvider.singleProductModel!.product!.reviewCount != null)?singleProductProvider.singleProductModel!.product!.reviewCount.toString() : 0} ${AppStrings.reviews.tr().toUpperCase()})",
                    style: TextStyle(
                        color: const Color(0xff1B1B1B).withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 11
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: ()async{
                       await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                        ),
                        builder: (BuildContext context) {
                          return SingleCommentBottomsheetWidget(id);
                        },
                      );
                       singleProductProvider.getOneProduct(context: context, id: id, crossSells: true);
                    },
                    child: Text(
                      AppStrings.showReview.tr().toUpperCase(),
                      style: const TextStyle(
                          color:  Color(0xffE6007E),
                          fontSize: 11,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if( singleProductProvider.productAttributesColors.isNotEmpty)Text("${AppStrings.colors.tr().toUpperCase()}:",style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff1B1B1B)),),
              if( singleProductProvider.productAttributesColors.isNotEmpty)const SizedBox(height: 8),
              if( singleProductProvider.productAttributesColors.isNotEmpty) Container(
                alignment: Alignment.center,
                height: 25,
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: ListView.separated(
                  shrinkWrap: true,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        singleProductProvider.changeColorIndex(singleProductProvider.productAttributesColors[index]['id']);
                        singleProductProvider.getOneProduct(context: context,crossSells: true, id: id, variation: true);
                        },
                      child: defaultCircleColor(
                          Color(int.parse("0xff${singleProductProvider.productAttributesColors[index]['data']}")),
                          (singleProductProvider.productVariationsColor == singleProductProvider.productAttributesColors[index]['id'])?const Color(0xff000000):Colors.transparent
                      ),
                    ),
                    separatorBuilder: (context, index) =>const SizedBox.shrink(),
                    itemCount: singleProductProvider.productAttributesColors.length
                ),
              ),
            ],
          );
        }
    );
  }
  Widget defaultCircleColor(
      final Color? color,
      final Color? borderColor,
      ){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 7),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor!)
      ),
    );
  }
}
//(singleProductProvider.selectColorIndex == index)?