import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutPaymentWidget extends StatefulWidget {
  @override
  State<CheckoutPaymentWidget> createState() => _CheckoutPaymentWidgetState();
}

class _CheckoutPaymentWidgetState extends State<CheckoutPaymentWidget> {
  int selectedPaymentIndex= 0;

  List paymentMethod = [
    {
      "name" : "Master Card",
      "image" : "assets/images/ecommerce/svg/mastercard.svg"
    },{
      "name" : "Visa Card",
      "image" : "assets/images/ecommerce/svg/visa.svg"
    },{
      "name" : "Debit/Credit Card",
      "image" : "assets/images/ecommerce/svg/visa.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
      ),
      child: ListView.separated(
          shrinkWrap: true,
          reverse: false,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index)=>GestureDetector(
            onTap: (){
              setState(() {
                selectedPaymentIndex = index;
              });
            },
            child: Container(
              height: 48,
              child: Row(
                children: [
                  SvgPicture.asset(
                    '${paymentMethod[index]['image']}',
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Text("${paymentMethod[index]["name"]}",
                    style: const TextStyle(
                        color: Color(0xff464646),
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (selectedPaymentIndex == index)?const Color(0xff027FEE) : Colors.transparent,
                        border: Border.all(color:const Color(0xff027FEE) )
                    ),
                  )
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index)=> SizedBox(height: 10, child: Divider(),),
          itemCount: paymentMethod.length
      ),
    );
  }
}
