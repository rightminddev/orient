import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottomsheet_location_widget.dart';
import 'package:provider/provider.dart';

class CheckoutLocationWidget extends StatelessWidget {
  const CheckoutLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutControllerProvider>(
        builder: (context, value, child) {
          return Container(
            padding:const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
            ),
            child: Row(
              children: [
                SvgPicture.asset("assets/images/ecommerce/svg/checkout_location.svg"),
                const SizedBox(width: 10),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((value.checkoutAddressId != null)?'${value.checkoutDefualtAddress}'.toUpperCase() : "${value.checkoutAddress['address']}" ,
                        style:const TextStyle(color: Color(0xff1B1B1B), fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: ()async{
                     await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                      ),
                      builder: (BuildContext context) {
                        return CheckoutBottomsheetLocationWidget();
                      },
                    );
                     WidgetsBinding.instance.addPostFrameCallback((_) {
                       value.getPrepareCheckout(context: context);
                     });
                  },
                  child: Text(
                    AppStrings.change.tr().toUpperCase(),
                    style: const TextStyle(color: Color(0xffE6007E), fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
