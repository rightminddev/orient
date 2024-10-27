import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottom_button_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_location_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_orderlist_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_payment_widget.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/modules/personal_profile/viewmodels/personal_profile.viewmodel.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class ECommerceCheckoutScreen extends StatefulWidget {
  @override
  _ECommerceCheckoutScreenState createState() => _ECommerceCheckoutScreenState();
}

class _ECommerceCheckoutScreenState extends State<ECommerceCheckoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutControllerProvider>(
      builder: (context, value, child) {
        print("CHECK FROM CHECK -> ${CheckConst.paymentStatus}");
        if (CheckConst.paymentStatus == 'failure') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (CheckConst.paymentStatus == 'failure') {
              defaultActionBottomSheet(
                context: context,
                title: "${AppStrings.failed.tr().toUpperCase()}!",
                buttonText: AppStrings.repayment.tr().toUpperCase(),
                subTitle: AppStrings.paymentFailed.tr().toUpperCase(),
                viewCheckIcon: true,
                onTapButton: () {
                  value.setPaymentStatus(null);
                  Navigator.pop(context);
                },
                headerIcon: SvgPicture.asset("assets/images/ecommerce/svg/failed.svg", height: 42, width: 40),
              );
            }
          });
        }
        if (CheckConst.paymentStatus == 'success') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (CheckConst.paymentStatus == 'failure') {
              defaultActionBottomSheet(
                context: context,
                title: "${AppStrings.successful.tr().toUpperCase()}!",
                buttonText: AppStrings.continueShopping.tr().toUpperCase(),
                subTitle: AppStrings.yourOrderWillBeDeliveredSoonThankYouForChoosingOurApp.tr().toUpperCase(),
                viewCheckIcon: true,
                onTapButton: () {
                    value.setPaymentStatus(null);
                    context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                        pathParameters: {'lang': context.locale.languageCode});
                },
                headerIcon: SvgPicture.asset("assets/images/ecommerce/svg/cart_success.svg", height: 42, width: 40),
              );
            }
          });
        }
        return Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body:(value.isPrepareCheckoutLoading)?
            SingleChildScrollView(
              child: Column(
                children: [
                  HomeLoadingPage(viewAppbar: false,),
                  HomeLoadingPage(viewAppbar: false,),
                ],
              ),
            )
                :Container(
                  height: MediaQuery.sizeOf(context).height * 1,
                  child: GradientBgImage(
                                  padding: EdgeInsets.zero,
                                  child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 90,
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Text(
                                AppStrings.checkout.tr().toUpperCase(),
                                style:const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                                  onPressed: (){}
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        defaultHeaderText(title: AppStrings.shippingAddress.tr().toUpperCase()),
                        const SizedBox(height: 15),
                        const CheckoutLocationWidget(),
                        const SizedBox(height: 16),
                        defaultHeaderText(title: AppStrings.paymentMethods.tr().toUpperCase()),
                        const SizedBox(height: 8),
                        CheckoutPaymentWidget(),
                        const SizedBox(height: 16),
                        defaultHeaderText(title: AppStrings.orderList.tr().toUpperCase()),
                        const SizedBox(height: 8),
                        CheckoutOrderListWidget(),
                      ],
                    ),
                  ),
                                  ),
                                ),
                ),
            bottomNavigationBar: (value.isPrepareCheckoutLoading)?Container(height: 180,) :const CheckoutBottomButtonWidget()
        );
      },
    );
  }
  Widget defaultHeaderText({title})=> Text(
    "$title".toUpperCase(),
    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xffE6007E)),
  );
}
