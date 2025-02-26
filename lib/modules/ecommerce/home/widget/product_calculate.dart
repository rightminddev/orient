import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/home/controller/calculate_controller.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class ProductCalculate extends StatefulWidget {
  var id;
  bool single = false;
  ProductCalculate({this.id, required this.single});
  @override
  State<ProductCalculate> createState() => _ProductCalculateState();
}

class _ProductCalculateState extends State<ProductCalculate> {
  final formKey = GlobalKey<FormState>();
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
              child: Row(
                children: [
                  Expanded(
                    child: defaultTextFormField(
                        context: context,
                        keyboardType: TextInputType.number,
                        controller: value.heightController,
                        hintText: AppStrings.height.tr(),
                        borderColor: const Color(0xffE3E5E5),
                        validator: (String? value){
                          if(value!.isEmpty){
                            return AppStrings.height.tr();
                          }
                        }
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: defaultTextFormField(
                        context: context,
                        keyboardType: TextInputType.number,
                        controller: value.widthController,
                        hintText: AppStrings.width.tr(),
                        borderColor: const Color(0xffE3E5E5),
                        validator: (String? value){
                          if(value!.isEmpty){
                            return AppStrings.width.tr();
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),
            if(widget.single == false) const SizedBox(height: 15,),
           if(widget.single == false) defaultDropdownField(
                borderColor: const Color(0xffE3E5E5),
                items: value.productsCalculate.map((value) {
                  return DropdownMenuItem(
                    value: value['id'].toString(),
                    child: Text(
                      value['title'].toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:const Color(0xff000000)
                              .withOpacity(0.74)),
                    ),
                  );
                }).toList(),
                title: AppStrings.product.tr(),
                isExpanded: true,
                value:  value.selectCategory,
              onChanged: (String? newValue) {
                setState(() {
                  value.selectCategory = newValue;
                });

              },
            ),
            const SizedBox(height: 20,),
            if(value.isPostProductCalculateLoading)const Center(child: CircularProgressIndicator(),),
            if(!value.isPostProductCalculateLoading) ButtonWidget(
              onPressed: (){
                if(formKey.currentState!.validate()){
                 setState(() {
                   result = double.parse(value.heightController.text) * double.parse(value.widthController.text);
                   final selectedIndex = value.productsCalculate.indexWhere(
                         (item) => item['id'].toString() ==  value.selectCategory,
                   );
                 });
                 value.postProductCalculate(context: context, id: (widget.single == false)?value.selectCategory : widget.id.toString(), area: result.toString());
                }
              },
              title: AppStrings.calculate.tr(),
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
        (value.calculateResult != null)? value.calculateResult.toString() : "0",
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
        child: ProductCalculate(single: false,)
      ),
    );
