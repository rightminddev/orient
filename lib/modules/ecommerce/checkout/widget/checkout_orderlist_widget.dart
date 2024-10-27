import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
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
                leading: Image.asset(
                  'assets/images/ecommerce/png/brown_paint.png',
                  width: 50,
                  height: 50,
                ),
                title: Text(value.checkoutListItems[index]['title'],
                  style:const TextStyle(color: Color(0xffE6007E), fontSize: 12, fontWeight: FontWeight.w600),
                ),
                subtitle: Text('${(value.checkoutListItems[index]['price_after_discount'] != null)?value.checkoutListItems[index]['price_after_discount']:value.checkoutListItems[index]['price']} EGP × ${value.checkoutListItems[index]['quantity']}',
                  style:const TextStyle(color: Color(0xff1B1B1B), fontSize: 12, fontWeight: FontWeight.w400),),
              ),
              itemCount: value.checkoutListItems.length,
              separatorBuilder: (context, index)=> const Divider(),
            ),
          );
        },
    );
  }
}
