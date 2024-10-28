import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:provider/provider.dart';

class CartEnterPromoWidget extends StatelessWidget {
  TextEditingController promoCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<CartControllerProvider>(
        builder: (context, value, child) {
          if (value.isAddCouponSuccess == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              value.getCart(context: context);
            });
            value.isAddCouponSuccess = false;
          }
          if (value.isDeleteCouponSuccess == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              value.getCart(context: context);
            });
            value.isDeleteCouponSuccess = false;
          }
          return Column(
            children: [
              Container(
                height: 51,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffE3E5E5)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: value.promoController,
                  decoration: InputDecoration(
                    hintText: AppStrings.enterYourPromoCode.tr().toUpperCase(),
                    labelStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff464646)),
                    hintStyle: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff464646)),
                    suffixIcon:(value.cartModel!.cart!.appliedCoupon == null)? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: (){
                          value.addCoupon(context: context, coupon: value.promoController.text);
                        },
                        child:Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffE6007E),
                            ),
                            child:(!value.isAddCouponLoading)? const Icon(
                              Icons.arrow_forward,
                              color: Color(0xffFFFFFF),
                              size: 20,
                            ) : const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: Color(0xffFFFFFF),),
                        ),)
                      ),
                    ) : Container(color: Colors.transparent, width: 0.001, height: 0.001,),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  keyboardType: TextInputType.text,
                  //validator: validator
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    "${AppStrings.promoCode.tr()} :    ".toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xffE6007E)),
                  ),
                  if(value.cartModel!.cart!.appliedCoupon != null) Container(
                    padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        //begin: const Alignment(-1, 0),
                        colors: [
                          const Color(0xFFFF007A).withOpacity(0.0),
                          const Color(0xFF00A1FF).withOpacity(0.33)
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                        value.cartModel!.cart!.appliedCoupon,
                          style:const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff0D3B6F),
                              fontSize: 11),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if(value.isDeleteCouponLoading)Container(
                          height: 5,
                          width: 5,
                          child: const CircularProgressIndicator(color: Color(0xffFFFFFF),),
                        ),
                        if(!value.isDeleteCouponLoading)GestureDetector(
                          onTap: (){
                            value.deleteCoupon(context: context,
                            coupon: value.cartModel!.cart!.appliedCoupon,
                            );
                          },
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: const Color(0xffE6007E),
                            child: SvgPicture.asset(
                              "assets/images/svg/x.svg",
                              width: 5,
                              height: 5,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
    );
  }
}
