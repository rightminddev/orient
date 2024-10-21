import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/settings/app_icons.dart';
import '../../../merchant/orders/models/order_status.dart';
import '../../../merchant/orders/view_models/orders.actions.viewmodel.dart';
import '../../../merchant/stores/view_models/stores.actions.viewmodel.dart';
import 'button_widget.dart';

Future<void> defaultActionBottomSheet(
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
    bool isLoading = false,
    void Function()? onTapButton}) async {
  return await showModalBottomSheet(
    context: context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xffE6007E).withOpacity(0.1),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffE6007E),
                              ),
                              child: headerIcon,
                            ),
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
                        onChanged: (value) {
                          setState(() {});
                          dropDownOnChanged != null
                              ? dropDownOnChanged(value)
                              : null;
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 30),
                ButtonWidget(
                  onPressed: onTapButton,
                  isLoading: isLoading,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s48, vertical: AppSizes.s16),
                  title: AppStrings.completeTheOrder.tr(),
                  svgIcon: AppIcons.checkMarkDashed,
                ),
                // GestureDetector(
                //   onTap: onTapButton,
                //   child: Container(
                //     height: 50,
                //     width: 225,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(50),
                //         color: const Color(0xff0D3B6F)),
                //     child: Text(
                //       buttonText!.toUpperCase(),
                //       style: const TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: Color(0xffFFFFFF),
                //           fontFamily: "Poppins"),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
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
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 30),
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
                // GestureDetector(
                //   onTap: onTapButton,
                //   child: Container(
                //     height: 50,
                //     width: 225,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(50),
                //         color: const Color(0xff0D3B6F)),
                //     child: Text(
                //       buttonText!.toUpperCase(),
                //       style: const TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: Color(0xffFFFFFF),
                //           fontFamily: "Poppins"),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
    },
  );
}

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
                        'SUBTOTAL',
                        style: TextStyle(
                          color: Color(0xFF0D3B6F),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        '$subTotal EGP',
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
                        'DISCOUNT',
                        style: TextStyle(
                          color: Color(0xFF0D3B6F),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        '$discount EGP',
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
                    'TOTAL PRICE',
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
                    '$total EGP',
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
