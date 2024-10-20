import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartViewPromoWidget extends StatelessWidget {
  const CartViewPromoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Promo code :    ".toUpperCase(),
          style:const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xffE6007E)
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              //begin: const Alignment(-1, 0),
              colors: [
                Color(0xFFFF007A).withOpacity(0.0),
                Color(0xFF00A1FF).withOpacity(0.33)
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Happy2023",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0D3B6F),
                    fontSize: 11
                ),
              ),
              SizedBox(width: 5,),
              CircleAvatar(
                radius: 8,
                backgroundColor:const Color(0xffE6007E),
                child: SvgPicture.asset("assets/images/svg/x.svg", width: 5, height: 5,),
              )
            ],
          ),
        )
      ],
    );
  }
}
