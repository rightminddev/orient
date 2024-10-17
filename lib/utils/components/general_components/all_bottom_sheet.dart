import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';

defaultActionBottomSheet(
        {required BuildContext? context,
        String? title,
        String? subTitle,
        required String? buttonText,
        bool viewCheckIcon = false,
        bool viewDropDownButton = false,
        String? dropDownValue,
        String? dropDownTitle,
        List<DropdownMenuItem<String>>? dropDownItems,
        void Function(String?)? dropDownOnChanged,
        Widget? headerIcon,
        double? bottomSheetHeight,
        void Function()? onTapButton}) =>
    showModalBottomSheet(
      context: context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            gradient: LinearGradient(
              colors: [Color(0xffFDFDFD), Color(0xffF4F7FF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          width: double.infinity,
          // height: (bottomSheetHeight != null)
          //     ? bottomSheetHeight
          //     : (viewDropDownButton == false)
          //     ? MediaQuery.sizeOf(context).height * 0.45
          //     : MediaQuery.sizeOf(context).height * 0.51,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    headerIcon != null
                        ? Container(
                            width: 88,
                            height: 88,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffE6007E).withOpacity(0.1),
                            ),
                            child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE6007E),
                                ),
                                child: headerIcon),
                          )
                        : SizedBox.shrink(),
                    if (viewCheckIcon == true)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Color(0xff38CF71),
                          child: Icon(
                            Icons.check,
                            color: Color(0xffFFFFFF),
                            size: 12,
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 20),
                if (title != null)
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color(0xffE6007E),
                    ),
                  ),
                const SizedBox(height: 10),
                if (subTitle != null)
                  Text(
                    subTitle,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1B1B1B),
                        fontFamily: "Poppins"),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 30),
                if (viewDropDownButton == true)
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.5),
                        child: Container(
                          height: 49,
                          decoration: BoxDecoration(
                            color: const Color(0xffE6007E),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      defaultDropdownField(
                          items: dropDownItems,
                          title: dropDownTitle,
                          value: dropDownValue,
                          onChanged: dropDownOnChanged),
                    ],
                  ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: onTapButton,
                  child: Container(
                    height: 50,
                    width: 225,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff0D3B6F)),
                    child: Text(
                      buttonText!.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Poppins"),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
