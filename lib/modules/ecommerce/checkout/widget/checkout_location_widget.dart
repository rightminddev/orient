import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottomsheet_location_widget.dart';

class CheckoutLocationWidget extends StatelessWidget {
  const CheckoutLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
      ),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/ecommerce/svg/checkout_location.svg"),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('90TH STREET, 5TH SETTLEMENT, NEW CAIRO, EGYPT.',
                  style: TextStyle(color: Color(0xff1B1B1B), fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: ()async{
              return await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                ),
                builder: (BuildContext context) {
                  return const CheckoutBottomsheetLocationWidget();
                },
              );
            },
            child: Text(
              AppStrings.change.tr().toUpperCase(),
              style: const TextStyle(color: Color(0xffE6007E), fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
