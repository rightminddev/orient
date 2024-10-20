import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/modules/ecommerce/cart/cart_screen.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';

class SingleBottomButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
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
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 26,
                child: const Text(
                  "TOTAL PRICE",
                  style: TextStyle(
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
            title: 'Add to cart'.toUpperCase(),
            svgIcon: "assets/images/ecommerce/svg/bag.svg",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ECommerceShoppingCart()));
            },
            padding: const EdgeInsets.symmetric(horizontal: 35,),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
