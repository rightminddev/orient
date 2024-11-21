import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class CartItemViewWidget extends StatefulWidget {
  const CartItemViewWidget({super.key});

  @override
  State<CartItemViewWidget> createState() => _CartItemViewWidgetState();
}

class _CartItemViewWidgetState extends State<CartItemViewWidget> {
  int count = 0;
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartControllerProvider>(
        builder: (context, value, child) {
          return value.cartModel!.cart!.items!.isNotEmpty?  Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: const Color(0xff0D3B6F),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 0,
                      maxHeight: 400,
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15 ,bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:const Color(0xffFFFFFF),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: false,
                      physics: ClampingScrollPhysics(),
                      itemCount: value.cartModel!.cart!.items!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              if(selectIndex == index + 1){
                                print("yes");
                                setState(() {
                                  selectIndex = 0;
                                  print(selectIndex);
                                });
                              }else{
                                setState(() {
                                  selectIndex = index+1;
                                  print(selectIndex);
                                });
                              }
                            },
                            child: Container(
                              height: 104,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: (value.cartModel!.cart!.items![index].image!.isNotEmpty)?value.cartModel!.cart!.items![index].image![0].file: "",
                                    width: 90,
                                    height: 99,
                                    placeholder: (context, url) => const ShimmerAnimatedLoading(
                                      circularRaduis: AppSizes.s50,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.image_not_supported_outlined,
                                      size: AppSizes.s32,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.cartModel!.cart!.items![index].title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Color(0xffE6007E),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "${value.cartModel!.cart!.items![index].priceAfterDiscount} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                                              style: const TextStyle(
                                                color: Color(0xff1B1B1B),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${value.cartModel!.cart!.items![index].price} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                                              style: TextStyle(
                                                color: const Color(0xff1B1B1B).withOpacity(0.5),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: 97,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    value.cartModel!.cart!.items![index].quantity--;
                                                  });
                                                  value.addItemCount(
                                                      context: context,
                                                      qty: value.cartModel!.cart!.items![index].quantity,
                                                      from: "other-page",
                                                      item_id: value.cartModel!.cart!.items![index].id
                                                  );
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                    border: Border.all(color: const Color(0xff0D3B6F)),
                                                  ),
                                                  child: const Icon(Icons.remove, color: Color(0xff0D3B6F), size: 16,),
                                                ),
                                              ),
                                              Text(value.cartModel!.cart!.items![index].quantity.toString().padLeft(2, '0'),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(0xff1B1B1B)
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    value.cartModel!.cart!.items![index].quantity++;
                                                  });
                                                  value.addItemCount(
                                                      context: context,
                                                      qty: value.cartModel!.cart!.items![index].quantity,
                                                      from: "other-page",
                                                      item_id: value.cartModel!.cart!.items![index].id
                                                  );
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                    border: Border.all(color: const Color(0xff0D3B6F)),
                                                  ),
                                                  child: const Icon(Icons.add, color: Color(0xff0D3B6F), size: 16,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: SvgPicture.asset("assets/images/svg/delete.svg"),
                                  )
                                ],
                              ),
                            )
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppStrings.subtotal.tr().toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xffFFFFFF)
                          ),
                        ),
                        if(value.isGetCartLoading || value.isAddItemCountLoading)Container(
                            padding: EdgeInsets.symmetric(horizontal: AppSizes.s18,),
                            child: CircularProgressIndicator(color: Color(0xffFFFFFF),)),
                       if(!value.isGetCartLoading && !value.isAddItemCountLoading) Text("${value.cartModel!.cart!.subTotal} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xffFFFFFF)
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ): Container(height: 0,);
        },
    );
  }
}

// Widget defaultCartItem({product, count}){
//   return StatefulBuilder(
//       builder: (BuildContext context, StateSetter setState){
//         return ;
//       }
//   );
// }
