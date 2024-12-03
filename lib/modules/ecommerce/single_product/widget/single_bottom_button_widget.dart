import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/bookmark/controller/bookmark_controller.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class SingleBottomButtonWidget extends StatelessWidget {
  var totalPriceAfter;
  var totalPriceBefore;
  var id;
  SingleBottomButtonWidget({@required this.totalPriceAfter,@required this.totalPriceBefore, required this.id});
  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductProvider>(builder:
    (context, value, child) {
      if (value.isAddtoCartSuccess == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.pushNamed(AppRoutes.eCommerceShoppingCartView.name,
              pathParameters: {'lang': context.locale.languageCode});
        });
        value.isAddtoCartSuccess = false;
      }

      return Consumer<BookmarkControllerProvider>(
          builder: (context, bookmarkControllerProvider, child){
            if(bookmarkControllerProvider.isSuccessAdd ==true){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                value.getCheck(context: context, id: id);
              });
              bookmarkControllerProvider.isSuccessAdd =false;
            }
            print("totalPriceBefore $totalPriceBefore");
            print("totalPriceAfter $totalPriceAfter");
            return Container(
              height: 136,
              decoration: BoxDecoration(
                color:const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(30),
                boxShadow:  [
                  BoxShadow(
                      color:const Color(0xff000000).withOpacity(0.1),
                      blurRadius: 11,
                      spreadRadius: 0,
                      offset:const Offset(0, -4)
                  )
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 26,
                        child: Text(
                          AppStrings.totalPrice.tr().toUpperCase(),
                          style:const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Color(0xff1B1B1B)
                          ),
                        ),
                      ),
                      Text(
                        "$totalPriceAfter ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                        style:const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff1B1B1B)
                        ),
                      ),
                      if(value.singleProductModel!.product!.price_after_discount != value.singleProductModel!.product!.price_before_discount)Text(
                        "$totalPriceBefore ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}"!,
                        style: const TextStyle(
                          color: Color(0xffE6007E),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Color(0xffE6007E),
                          decorationThickness: 2,
                        ),
                      ),
                    ],
                  ),
                  if(value.isAddtoCartLoading)Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric( vertical: AppSizes.s12),
                      child: CircularProgressIndicator()),
                  SizedBox(width : 15),
                  if(!value.isAddtoCartLoading)ButtonWidget(
                    buttonWidth: MediaQuery.sizeOf(context).width * 0.5,
                    title: AppStrings.addToCart.tr().toUpperCase(),
                    svgIcon: "assets/images/ecommerce/svg/bag.svg",
                    onPressed: () {
                      value.addToCart(
                          context: context,
                          id: id,
                          qty: value.count
                      );
                    },
                    padding: EdgeInsets.zero,
                    fontSize: 12,
                  ),
                  SizedBox(width : 15),
                  if(bookmarkControllerProvider.isLoadingAdd) Container(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator()),
                 if(!bookmarkControllerProvider.isLoadingAdd) GestureDetector(
                      onTap: (){
                        bookmarkControllerProvider.addOrRemoveBookMark(context, action:value.check == true ?
                        "remove" : "add", id: id);
                      },
                      child: SvgPicture.asset("assets/images/svg/book_single.svg", fit: BoxFit.cover,
                        color: value.check == true ? Colors.amberAccent :const Color(0xff0D3B6F) )),
                ],
              ),
            );
          }
      );
    },
    );
  }
}
