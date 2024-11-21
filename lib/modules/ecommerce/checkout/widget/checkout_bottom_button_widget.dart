import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class CheckoutBottomButtonWidget extends StatelessWidget {
  const CheckoutBottomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutControllerProvider>(
        builder: (context, value, child) {
          if (value.isConfirmOrderSuccess == true) {
            if(value.paymentUrl == null){
              value.isUpdateCartSuccess == false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                defaultActionBottomSheet(
                    context: context,
                    title: "${AppStrings.successful.tr().toUpperCase()} !",
                    buttonText: AppStrings.continueShopping.tr().toUpperCase(),
                    subTitle: AppStrings.yourOrderWillBeDeliveredSoonThankYouForChoosingOurApp.tr().toUpperCase(),
                    viewCheckIcon: true,
                    onTapButton: (){
                     // value.isUpdateCartSuccess == false;
                      context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                        pathParameters: {'lang': context.locale.languageCode});},
                    headerIcon: SvgPicture.asset("assets/images/ecommerce/svg/cart_success.svg", height: 42, width: 40,)
                );
              });
              value.isConfirmOrderSuccess = false;
            }else{
              value.isUpdateCartSuccess == false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushNamed(AppRoutes.eCommerceWebViewScreen.name,
                    pathParameters: {'lang': context.locale.languageCode,
                    'url': value.paymentUrl!
                    });
              });
              value.isConfirmOrderSuccess = false;
            }
          }
          return Consumer<HomeViewModel>(builder:
          (context, values, child) {
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
                        Text("${value.checkoutSubtotal} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff464646)),),
                      ],
                    ),
                  ),
                  if(value.checkoutFees != null && value.checkoutFees != 0) Container(
                    height: 18,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.shippingFees.tr().toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xff0D3B6F)),),
                        Text("${value.checkoutFees} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff464646)),),
                      ],
                    ),
                  ),
                  if(value.checkoutDiscountTotal != null && value.checkoutDiscountTotal != 0) Container(
                    height: 18,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.discount.tr().toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xff0D3B6F)),),
                        Text("${value.checkoutDiscountTotal} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff464646)),),
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
                            Text(
                              "${value.checkoutTotal} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              style:const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff1B1B1B)
                              ),
                            ),
                          ],
                        ),
                        if(value.isConfirmOrderLoading || value.isUpdateCartLoading)Container(
                            padding: EdgeInsets.symmetric(horizontal: AppSizes.s18, vertical: AppSizes.s12),
                            child: CircularProgressIndicator()),
                        if(!value.isConfirmOrderLoading && !value.isUpdateCartLoading == true) ButtonWidget(
                          title: AppStrings.checkout.tr().toUpperCase(),
                          svgIcon: "assets/images/ecommerce/svg/verifiy.svg",
                          onPressed: () {
                              value.confirmOrder(
                                context: context,
                                country_id: CheckConst.userAddressModel!.countryId,
                                city_id: CheckConst.userAddressModel!.cityId,
                                email: values.userSettings!.email,
                                name: values.userSettings!.name,
                                phone: values.userSettings!.phone,
                                address: CheckConst.userAddressModel!.address,
                                country_key: CheckConst.userAddressModel!.countryKey,
                                state_id: CheckConst.userAddressModel!.stateId,
                              );

                          },
                          padding: EdgeInsets.zero,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          );
        },
    );
  }
}
