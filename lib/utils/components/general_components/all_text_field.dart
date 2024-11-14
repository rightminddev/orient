import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  String? hintText,
  Widget? suffixIcon,
  bool? hasShadows = true,
  Widget? prefixIcon,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  int maxLines = 1,
  List<BoxShadow>? boxShadow,
  double? containerHeight,
  Color? borderColor,
  TextInputAction? textInputAction,
  void Function(String)? onFieldSubmitted
}){
  return Container(
    height: containerHeight ?? 50,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(vertical: AppSizes.s10),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: (maxLines! > 1) ? 16: 0),
    decoration: ShapeDecoration(
      color: AppThemeService.colorPalette.tertiaryColorBackground.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        side:  BorderSide(
          color: borderColor ?? const Color(0xffE3E5E5),
          width: 1.0,
        ),
      ),
      shadows:(hasShadows == true)? const [
        BoxShadow(
          color: Color(0x0C000000),
          blurRadius: 10,
          offset: Offset(0, 1),
          spreadRadius: 0,
        )
      ]: null,
    ),
    child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: hintText ?? "Input",
          labelStyle: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff191C1F)
          ),
          hintStyle:const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff464646)
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}
Widget defaultTextFormFieldUpdate({
  TextEditingController? controller,
  String? hintText,
  void Function()? onTap
}){
  return Container(
    height: 50,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(vertical: AppSizes.s10),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    decoration: ShapeDecoration(
      color: AppThemeService.colorPalette.tertiaryColorBackground.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        side:  const BorderSide(
          color: Color(0xffE3E5E5),
          width: 1.0,
        ),
      ),
    ),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff191C1F)
        ),
        hintStyle:const TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff464646)
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(AppColors.oc1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(AppStrings.update.tr().toUpperCase(), style: const TextStyle(color: Color(0xffFFFFFF),fontWeight: FontWeight.w500, fontSize: 12),),
            ),
          ),
        ),
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
      ),
      keyboardType: TextInputType.phone,
      validator: (String? value){
        return AppStrings.pleaseEnterValidPhoneNumber.tr();
      },
    ),
  );
}
Widget defaultCommentTextFormField({
  TextEditingController? controller,
  String? hintText,
  String? Function(String?)? validator,
  void Function()? onTapSend,
  TextInputType? keyboardType,
  int maxLines = 1,
  List<BoxShadow>? boxShadow,
  bool? viewDropDownRates,
  List<DropdownMenuItem<String>>? dropDownItems,
  Widget? dropDownHint,
  String? dropDownValue,
  Color? borderColor,
  void Function(String?)?  dropDownOnChanged
}){
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 48,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: (maxLines! > 1) ? 16: 0),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: borderColor ?? Colors.transparent),
              boxShadow: boxShadow
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    controller: controller,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      hintText: hintText,
                      labelStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff191C1F)
                      ),
                      hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff464646).withOpacity(0.5)
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none
                    ),
                    keyboardType: keyboardType,
                    validator: validator
                ),
              ),
          if(viewDropDownRates == true)Container(
            height: 26,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color:const Color(0xffFFFABB),
              borderRadius: BorderRadius.circular(18.5),
            ),
            child: DropdownButton<String>(
                dropdownColor: Colors.white,
                icon:const Icon(Icons.arrow_drop_down_sharp, color: Color(0xffE6007E),),
                isExpanded: false,
                hint: dropDownHint,
                items: dropDownItems,
                value: dropDownValue,
                underline: const SizedBox.shrink(),
                onChanged: dropDownOnChanged
            ),
          ),
            ],
          ),
        ),
      ),
      SizedBox(width: 14,),
      GestureDetector(
        onTap: onTapSend,
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: const Color(0xffEE3F80)
          ),
          child: SvgPicture.asset("assets/images/svg/send.svg", fit: BoxFit.scaleDown,),
        ),
      )
    ],
  );
}
Widget defaultDropdownField({
  String? value,
  String? title,
  bool? isExpanded,
  Color? borderColor,
  required  items,
  required void Function(String?)? onChanged
}){
  return  Container(
    height: 50,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    decoration: ShapeDecoration(
      color: AppThemeService.colorPalette.tertiaryColorBackground.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s10),
        side:  BorderSide(
          color: borderColor ?? const Color(0xffE3E5E5),
          width: 1.0,
        ),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x0C000000),
          blurRadius: 10,
          offset: Offset(0, 1),
          spreadRadius: 0,
        )
      ],
    ),
    child: DropdownButton<String>(
        dropdownColor: Colors.white,
        icon:const Icon(Icons.arrow_drop_down_sharp, color: Color(0xffE6007E),),
        isExpanded: isExpanded ?? true,
        value: value,
        hint: Text(
          title!,
          style:const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff464646)
          ),
        ),
        items: items,
        underline: const SizedBox.shrink(),
        onChanged: onChanged
    ),
  );
}
Widget defaultUploadLinkAndImage({
  required String? title,
  required void Function()? onTapIcon,
  required Widget? icon,
  double? containerHeight
}){
  return Container(
    height: containerHeight ?? 48,
    width: 48,
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffEE3F80)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!,
          style: const TextStyle(
              fontFamily: "Poppins",
              color: Color(0xff464646),
              fontWeight: FontWeight.w400,
              fontSize: 12
          ),
        ),
        GestureDetector(
          onTap: onTapIcon,
          child: icon,
        )
      ],
    ),
  );
}


Widget buildTextFieldDate(
    {String? labelText, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: AppSizes.s10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: ShapeDecoration(
          color: AppThemeService.colorPalette.tertiaryColorBackground.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s8),
            side:  const BorderSide(
              color: Color(0xffE3E5E5),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(labelText!, style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff464646)
            ),),
            Spacer(),
            SvgPicture.asset("assets/images/calender.svg")
          ],
        ),
      ),
    ),
  );
}