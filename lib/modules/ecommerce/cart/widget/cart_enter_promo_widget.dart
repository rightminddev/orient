import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';

class CartEnterPromoWidget extends StatelessWidget {
  TextEditingController promoCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      alignment: Alignment.center,
      padding:const EdgeInsets.symmetric(horizontal: 16,),
      decoration: BoxDecoration(
        color:const Color(0xffFFFFFF),
        border: Border.all(color: const Color(0xffE3E5E5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: promoCodeController,
        decoration: InputDecoration(
          hintText: AppStrings.enterYourPromoCode.tr().toUpperCase(),
          labelStyle:  const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff464646)
          ),
          hintStyle:const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff464646)
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffE6007E),
                ),
                child:const Icon(Icons.arrow_forward, color: Color(0xffFFFFFF), size: 20,)
            ),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        ),
        keyboardType: TextInputType.text,
        //validator: validator
      ),
    );
  }
}
