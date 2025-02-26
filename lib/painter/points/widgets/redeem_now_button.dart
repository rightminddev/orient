import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';


class RedeemNowButton extends StatelessWidget {
  final bool friends;
  const RedeemNowButton({Key? key, this.friends = false}) : super(key: key);

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
         if(friends == false) Image.asset("assets/images/png/icon.png"),
         if(friends == true) SvgPicture.asset("assets/images/svg/sFriend.svg"),
          gapW4,
          Text(friends == false?AppStrings.redeemNow.tr().toUpperCase():AppStrings.sendToFriends.tr().toUpperCase(),style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),)
        ],
      ),
    );
  }
}
