import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/merchant/orders/models/order_status.dart';
import 'package:orient/merchant/orders/view_models/orders.actions.viewmodel.dart';
import 'package:orient/merchant/stores/view_models/stores.actions.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

defaultActionBottomSheet(
    {required BuildContext? context,
      required String? title,
      required String? subTitle,
       String? buttonText,
      bool viewCheckIcon = false,
      bool viewDropDownButton = false,
      String? dropDownValue,
      String? dropDownTitle,
      String? textFormFieldHint,
      TextEditingController? textFormFieldController,
      bool? view = false,
      bool? widgetTextFormField = false,
      bool? viewHeaderIcon = true,
      Widget? buttonWidget,
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
                   if(viewHeaderIcon == true) Stack(
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
                            padding: const EdgeInsets.all(5),
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
                    if (viewDropDownButton == true)Stack(
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
                    if(widgetTextFormField == true) defaultTextFormField(
                      hintText: textFormFieldHint,
                      controller: textFormFieldController
                    ),
                    const SizedBox(height: 30),
                    if(view == true) const Center(child: CircularProgressIndicator(),),
                    if(view == false)GestureDetector(
                      onTap: onTapButton,
                      child: Container(
                        height: 50,
                        width: 225,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff0D3B6F)),
                        child: (buttonWidget !=null)? buttonWidget:Text(
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

Future<void> completeOrderActionBottomSheet({
  required BuildContext context,
  required int total,
  required int subTotal,
  required int discount,
  required StoreActionsViewModel storeActionsViewModel,
  required VoidCallback onTapButton,
}) async {
  return await showModalBottomSheet(
    context: context,
    enableDrag: true, isScrollControlled: true,

    // showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => storeActionsViewModel,
        child: Consumer<StoreActionsViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.subtotal.tr().toUpperCase(),
                        style: TextStyle(
                          color: Color(0xFF0D3B6F),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        '$subTotal ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}',
                        style: TextStyle(
                          color: Color(0xFF595959),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.discount.tr().toUpperCase(),
                        style: TextStyle(
                          color: Color(0xFF0D3B6F),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        '$discount ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}',
                        style: TextStyle(
                          color: Color(0xFF595959),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    AppStrings.totalPrice.tr().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.20,
                      letterSpacing: 0.10,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    '$total ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.12,
                    ),
                  ),
                  SizedBox(height: 24),
                  ButtonWidget(
                    onPressed: onTapButton,
                    isLoading: viewModel.isLoadingDialog,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s48, vertical: AppSizes.s16),
                    title: AppStrings.completeTheOrder.tr(),
                    svgIcon: AppIcons.checkMarkDashed,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
Future<void> orderStatusActionBottomSheet(
    {required BuildContext? context,
      required String? buttonText,
      OrderActionsViewModel? orderActionsViewModel,
      String? dropDownTitle,
      List<DropdownMenuItem<String>>? dropDownItems,
      void Function(String?)? dropDownOnChanged,
      bool isLoading = false,
      void Function(OrderStatus)? onItemTap,
      void Function()? onTapButton}) async {
  return await showModalBottomSheet(
    context: context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      String? value;
      return StatefulBuilder(
        builder: (context, setState) => Container(
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
          //alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      items: orderStatusMap
                          .map(
                            (index, element) => MapEntry(
                          index,
                          DropdownMenuItem<String>(
                            onTap: () {
                              onItemTap != null ? onItemTap(index) : null;
                              setState(() {
                                value = orderStatusMap[index];
                              });
                            },
                            value: element,
                            child: Text(
                              element,
                              style: const TextStyle(
                                color: Color(0xFF464646),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.11,
                              ),
                            ),
                          ),
                        ),
                      )
                          .values
                          .toList(),
                      title: dropDownTitle,
                      value: value,
                      onChanged: dropDownOnChanged,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ChangeNotifierProvider<OrderActionsViewModel>(
                  create: (_) => orderActionsViewModel!,
                  child: Consumer<OrderActionsViewModel>(
                    builder: (context, model, child) {
                      return ButtonWidget(
                        onPressed: onTapButton,
                        isLoading: model.isLoading,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s48, vertical: AppSizes.s16),
                        title: AppStrings.completeTheOrder.tr(),
                        svgIcon: AppIcons.checkMarkDashed,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
