import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';

showCalculateDialog({context, controller, value})=> AlertDialog(
      backgroundColor:const Color(0xffFFFFFF),
      surfaceTintColor:const Color(0xffFFFFFF),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            defaultTextFormField(
                controller: controller,
                hintText: AppStrings.numberOfMeters.tr(),
                borderColor: const Color(0xffE3E5E5),
                validator: (String? value){
                  if(value!.isEmpty){
                    return AppStrings.numberOfMeters.tr();
                  }
                }
            ),
            SizedBox(height: 15,),
            defaultDropdownField(
                borderColor: const Color(0xffE3E5E5),
                items: ["A", "B"].map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000)
                              .withOpacity(0.74)),
                    ),
                  );
                }).toList(),
                title: "Category",
                isExpanded: true,
                value: value,
                onChanged: (String? value){
                }
            ),
            const SizedBox(height: 20,),
            ButtonWidget(
              onPressed: (){
                if(controller.text.isNotEmpty){
                }
              },
              title: "Calculate",
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              svgIcon: "assets/images/ecommerce/svg/calculate.svg",
            ),
            const SizedBox(height: 20,),
            Container(
              height: 110,
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.theNumberOfPaintSheetsUsedIs.tr().toUpperCase(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style:const TextStyle(fontSize: 20,
                        color: Color(0xff1B1B1B),
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    "${controller.text} ${AppStrings.sheets.tr().toUpperCase()}",
                    style:const TextStyle(fontSize: 20,
                        color: Color(0xffE6007E),
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
