import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottom_button_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_location_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_orderlist_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_payment_widget.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class ECommerceCheckoutScreen extends StatefulWidget {
  @override
  _ECommerceCheckoutScreenState createState() => _ECommerceCheckoutScreenState();
}

class _ECommerceCheckoutScreenState extends State<ECommerceCheckoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title:  Text(
          AppStrings.checkout.tr().toUpperCase(),
          style:const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
      bottomNavigationBar: const CheckoutBottomButtonWidget()
    );
  }
  Widget defaultHeaderText({title})=> Text(
    "$title".toUpperCase(),
    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xffE6007E)),
  );
}
