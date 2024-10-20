import 'package:flutter/material.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';

defaultActionBottomSheet(
    {required BuildContext? context,
      required String? title,
      required String? subTitle,
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
            gradient: LinearGradient(
              colors: [Color(0xffFDFDFD), Color(0xffF4F7FF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          width: double.infinity,
          height: (bottomSheetHeight != null)
              ? bottomSheetHeight
              : (viewDropDownButton == false)
              ? MediaQuery.sizeOf(context).height * 0.5
              : MediaQuery.sizeOf(context).height * 0.56,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 15,),
              Center(
                child: Container(
                 height: 5,
                 width: 63,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   color: Color(0xffB9C0C9)
                 ), 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffE6007E).withOpacity(0.05),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffE6007E),
                              ),
                              child: headerIcon),
                        ),
                        if (viewCheckIcon == true)
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: const Color(0xff38CF71),
                              child: Icon(
                                Icons.check,
                                color: const Color(0xffFFFFFF),
                                size: 12,
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title!.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xffE6007E),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      subTitle!,
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
            ],
          ),
        );
      },
    );