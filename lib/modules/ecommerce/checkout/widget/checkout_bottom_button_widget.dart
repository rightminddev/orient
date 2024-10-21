import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';

class CheckoutBottomButtonWidget extends StatelessWidget {
  const CheckoutBottomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.subtotal.tr().toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xff0D3B6F)),),
                Text("30000 EGP".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff464646)),),
              ],
            ),
          ),
          Container(
            height: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.shippingFees.tr().toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xff0D3B6F)),),
                Text("4521 EGP".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff464646)),),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text(
                      "34521 EGP",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff1B1B1B)
                      ),
                    ),
                  ],
                ),
                ButtonWidget(
                  title: AppStrings.checkout.tr().toUpperCase(),
                  svgIcon: "assets/images/ecommerce/svg/verifiy.svg",
                  onPressed: () {
                    defaultActionBottomSheet(
                      context: context,
                      title: "${AppStrings.successful.tr().toUpperCase()} !",
                      buttonText: AppStrings.continueShopping.tr().toUpperCase(),
                      subTitle: AppStrings.yourOrderWillBeDeliveredSoonThankYouForChoosingOurApp.tr().toUpperCase(),
                      viewCheckIcon: true,
                      onTapButton: (){Navigator.pop(context);},
                      headerIcon: SvgPicture.asset("assets/images/ecommerce/svg/cart_success.svg", height: 42, width: 40,)
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 35,),
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
