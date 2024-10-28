import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/home/controller/calculate_controller.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class ProductCalculate extends StatefulWidget {
  @override
  State<ProductCalculate> createState() => _ProductCalculateState();
}

class _ProductCalculateState extends State<ProductCalculate> {
  TextEditingController numberOfMetersController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectCategory;
  double? result = 0;
  String units = '';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => CalculateController()..getProductCalculate(context: context),
    child: Consumer<CalculateController>(
      builder: (context, value, child) {
        return(value.isProductCalculateLoading)?
         const SizedBox.shrink()
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: defaultTextFormField(
                  controller:numberOfMetersController,
                  hintText: AppStrings.numberOfMeters.tr(),
                  borderColor: const Color(0xffE3E5E5),
                  validator: (String? value){
                    if(value!.isEmpty){
                      return AppStrings.numberOfMeters.tr();
                    }
                  }
              ),
            ),
            const SizedBox(height: 15,),
            defaultDropdownField(
                borderColor: const Color(0xffE3E5E5),
                items: value.productsCalculate.map((value) {
                  return DropdownMenuItem(
                    value: value['space'].toString(),
                    child: Text(
                      value['category']['title'].toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:const Color(0xff000000)
                              .withOpacity(0.74)),
                    ),
                  );
                }).toList(),
                title: AppStrings.type.tr(),
                isExpanded: true,
                value: selectCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20,),
            ButtonWidget(
              onPressed: (){
                if(formKey.currentState!.validate() && selectCategory != null){
                 setState(() {
                   result = double.parse(numberOfMetersController.text) / double.parse("$selectCategory");
                   final selectedIndex = value.productsCalculate.indexWhere(
                         (item) => item['space'].toString() == selectCategory,
                   );
                   if (selectedIndex != -1) {
                     units = LocalizationService.isArabic(context: context)
                         ? value.productsCalculate[selectedIndex]['unit']['ar']
                         : value.productsCalculate[selectedIndex]['unit']['en'];
                   }
                 });
                }
              },
              title: "Calculate",
              padding: EdgeInsets.zero,
              svgIcon: "assets/images/ecommerce/svg/calculate.svg",
            ),
            const SizedBox(height: 20,),
            Container(
              height: 110,
              padding:const EdgeInsets.symmetric(vertical: 5),
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
                    "${result!.toStringAsFixed(2)} ${units.toUpperCase()}",
                    style:const TextStyle(fontSize: 20,
                        color: Color(0xffE6007E),
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    ),
    );
  }
}

showCalculateDialog({context, controller, value})=> AlertDialog(
      backgroundColor:const Color(0xffFFFFFF),
      surfaceTintColor:const Color(0xffFFFFFF),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductCalculate()
      ),
    );
