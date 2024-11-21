import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class CheckoutOrderListWidget extends StatelessWidget {
  const CheckoutOrderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutControllerProvider>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics:const NeverScrollableScrollPhysics(),
              reverse: false,
              shrinkWrap: true,
              itemBuilder: (context, index)=> ListTile(
                leading: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  imageUrl: (value.updateCartModel !=null)? value.updateCartModel!.cart!.items![index].image![0].file : value.checkoutListItems[index]['image'][0]['file'],
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const ShimmerAnimatedLoading(
                    circularRaduis: AppSizes.s50,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported_outlined,
                    size: AppSizes.s32,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  (value.updateCartModel !=null)?value.updateCartModel!.cart!.items![index].title:
                  value.checkoutListItems[index]['title'],
                  style:const TextStyle(color: Color(0xffE6007E), fontSize: 12, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  (value.updateCartModel !=null)?
                  '${(value.updateCartModel!.cart!.items![index].priceAfterDiscount != null)?value.updateCartModel!.cart!.items![index].priceAfterDiscount: value.updateCartModel!.cart!.items![index].price} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"} × ${value.updateCartModel!.cart!.items![index].quantity}':
                  '${(value.checkoutListItems[index]['price_after_discount'] != null)?value.checkoutListItems[index]['price_after_discount']:value.checkoutListItems[index]['price']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"} × ${value.checkoutListItems[index]['quantity']}',
                  style:const TextStyle(color: Color(0xff1B1B1B), fontSize: 12, fontWeight: FontWeight.w400),),
              ),
              itemCount: (value.updateCartModel !=null)?value.updateCartModel!.cart!.items!.length : value.checkoutListItems.length,
              separatorBuilder: (context, index)=> const Divider(),
            ),
          );
        },
    );
  }
}
