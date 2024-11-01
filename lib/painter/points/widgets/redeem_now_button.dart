import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';


class RedeemNowButton extends StatelessWidget {
  const RedeemNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xFFE6007E),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/png/icon.png"),
          gapW4,
          Text("Redeem Now",style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),)
        ],
      ),
    );
  }
}
