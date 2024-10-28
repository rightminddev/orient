import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';

Widget defaultTextFormField(
    {TextEditingController? controller,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    List<BoxShadow>? boxShadow,
    double? containerHeight,
    Color? borderColor,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted}) {
  return Container(
    height: containerHeight ?? 48,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
    padding: EdgeInsets.symmetric(
        horizontal: 16, vertical: (maxLines > 1) ? 16 : 0),
    decoration: ShapeDecoration(
      color: AppThemeService.colorPalette.tertiaryColorBackground.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        side: BorderSide(
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
            color: Color(0xff191C1F)),
        hintStyle: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff464646)),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}

Widget defaultCommentTextFormField(
    {TextEditingController? controller,
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
    void Function(String?)? dropDownOnChanged}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 48,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: 16, vertical: (maxLines > 1) ? 16 : 0),
          decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(100),
              boxShadow: boxShadow),
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
                            color: Color(0xff191C1F)),
                        hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff464646).withOpacity(0.5)),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    keyboardType: keyboardType,
                    validator: validator),
              ),
              if (viewDropDownRates == true)
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFABB),
                    borderRadius: BorderRadius.circular(18.5),
                  ),
                  child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Color(0xffE6007E),
                      ),
                      isExpanded: false,
                      hint: dropDownHint,
                      items: dropDownItems,
                      value: dropDownValue,
                      underline: const SizedBox.shrink(),
                      onChanged: dropDownOnChanged),
                ),
            ],
          ),
        ),
      ),
      const SizedBox(
        width: 14,
      ),
      GestureDetector(
        onTap: onTapSend,
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: const Color(0xffEE3F80)),
          child: SvgPicture.asset(
            "assets/images/svg/send.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
      )
    ],
  );
}

Widget defaultDropdownField(
    {String? value,
    String? title,
    bool? isExpanded,
    required items,
    required void Function(String?)? onChanged}) {
  return Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: const Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Color(0xffE6007E),
        ),
        isExpanded: isExpanded ?? true,
        value: value,
        hint: Text(
          title!,
          style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff464646)),
        ),
        items: items,
        underline: const SizedBox.shrink(),
        onChanged: onChanged),
  );
}

Widget defaultUploadLinkAndImage(
    {required String? title,
    required void Function()? onTapIcon,
    required Widget? icon,
    double? containerHeight}) {
  return Container(
    height: containerHeight ?? 48,
    width: 48,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: const Color(0xffEE3F80)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: const TextStyle(
              fontFamily: "Poppins",
              color: Color(0xff464646),
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
        GestureDetector(
          onTap: onTapIcon,
          child: icon,
        )
      ],
    ),
  );
}

Widget defaultTextFieldCodeSendNow({
  TextEditingController? controller,
  String? hintText,
  Widget? suffixIcon,
  String? Function(String?)? validator,
  void Function()? onTapButton,
  int maxLines = 1,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 16, vertical: (maxLines > 1) ? 16 : 0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xffFFFFFF),
      borderRadius: BorderRadius.circular(8),
      boxShadow: boxShadow,
    ),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xff1B1B1B).withOpacity(0.5)),
          labelStyle: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff191C1F)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 12),
          hintText: hintText ?? 'XXXX-XXXX-XXXX-XXXX',
          suffixIcon: GestureDetector(
            onTap: onTapButton,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/svg/logo.png',
                  width: 20,
                  height: 20,
                ),
                const Text(
                  'Send Now',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffE6007E),
                  ),
                )
              ],
            ),
          )),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        _NumberInputFormatter(),
      ],
      maxLines: maxLines,
      validator: validator,
    ),
  );
}

class _NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', '');
    if (text.length > 16) text = text.substring(0, 16);
    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      formattedText += text[i];
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        formattedText += '-';
      }
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
