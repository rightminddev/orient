import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:orient/modules/ecommerce/checkout/checkout_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class CartBottomButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartControllerProvider>(
        builder: (context, value, child) {
          return (value.cartModel == null) ?
          Container(
            height: 136,
          ):
          Container(
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
                      child:  Text(
                        AppStrings.totalPrice.tr().toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xff1B1B1B)
                        ),
                      ),
                    ),
                     Text(
                      "${value.cartModel!.cart!.subTotal} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                      style:const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff1B1B1B)
                      ),
                    ),
                  ],
                ),
                ButtonWidget(
                  title: AppStrings.proceedToCheckout.tr().toUpperCase(),
                  svgIcon: "assets/images/ecommerce/svg/cart.svg",
                  onPressed: () {
                    context.pushNamed(AppRoutes.eCommerceCheckoutScreenView.name,
                        pathParameters: {'lang': context.locale.languageCode,
                        });
                  },
                  padding: EdgeInsets.zero,
                  fontSize: 12,
                ),
              ],
            ),
          );
        },
    );
  }
}
