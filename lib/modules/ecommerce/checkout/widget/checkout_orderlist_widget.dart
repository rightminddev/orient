import 'package:flutter/material.dart';

class CheckoutOrderListWidget extends StatelessWidget {
  const CheckoutOrderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
      ),
      child: ListView.separated(
        physics:const NeverScrollableScrollPhysics(),
        reverse: false,
        shrinkWrap: true,
        itemBuilder: (context, index)=> ListTile(
          leading: Image.asset(
            'assets/images/ecommerce/png/brown_paint.png',
            width: 50,
            height: 50,
          ),
          title: const Text('PUTTY (ACRYLIC 1000) 233',
            style: TextStyle(color: Color(0xffE6007E), fontSize: 12, fontWeight: FontWeight.w600),
          ),
          subtitle:const Text('2512 EGP × 2',
            style: TextStyle(color: Color(0xff1B1B1B), fontSize: 12, fontWeight: FontWeight.w400),),
        ),
        itemCount: 4,
        separatorBuilder: (context, index)=> const Divider(),
      ),
    );
  }
}
