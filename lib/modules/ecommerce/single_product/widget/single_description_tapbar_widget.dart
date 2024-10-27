import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/single_product/controller/single_product_controller.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class SingleDescriptionTapbarWidget extends StatefulWidget {
  int selectIndex;
  String? description;

   SingleDescriptionTapbarWidget({required this.selectIndex, this.description});

  @override
  State<SingleDescriptionTapbarWidget> createState() => _SingleDescriptionTapbarWidgetState();
}

class _SingleDescriptionTapbarWidgetState extends State<SingleDescriptionTapbarWidget> {
  String? selectCategory;

var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleProductProvider>(
        builder: (context, singleProductProvider, child){
          return Padding(
            padding:const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.selectIndex == 0) Text(
                  "${singleProductProvider.singleProductModel!.product!.description}",
                  style:const TextStyle(fontSize: 12,
                  color: Color(0xff1B1B1B),
                    fontWeight: FontWeight.w400
                  ),
                ),
                if(widget.selectIndex == 1) Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey,
                      child: defaultTextFormField(
                        controller:singleProductProvider.numberOfMetersController,
                        hintText: AppStrings.numberOfMeters.tr(),
                        borderColor: const Color(0xffE3E5E5),
                        validator: (String? value){
                          if(value!.isEmpty){
                            return AppStrings.numberOfMeters.tr();
                          }
                        }
                      ),
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
                        title: AppStrings.type.tr(),
                        isExpanded: true,
                        value: selectCategory,
                        onChanged: (String? value){
                          setState(() {
                            selectCategory = value;
                          });
                        }
                    ),
                    const SizedBox(height: 20,),
                    ButtonWidget(
                        onPressed: (){
                          if(formKey.currentState!.validate() && selectCategory != null){
                          }
                        },
                        title: "Calculate",
                      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
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
                            "${singleProductProvider.numberOfMetersController.text} ${AppStrings.sheets.tr().toUpperCase()}",
                            style:const TextStyle(fontSize: 20,
                                color: Color(0xffE6007E),
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
    );
  }
}
