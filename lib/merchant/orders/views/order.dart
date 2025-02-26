import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/app_icons.dart';
import 'package:orient/merchant/orders/models/order_status.dart';
import 'package:orient/merchant/orders/view_models/orders.actions.viewmodel.dart';
import 'package:orient/merchant/orders/view_models/orders.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_sizes.dart';

class OrderDropDownWidget extends StatefulWidget {
  var storeId;
  var orderId;
  OrderDropDownWidget(this.storeId, this.orderId);
  @override
  State<OrderDropDownWidget> createState() => _OrderDropDownWidgetState();
}

class _OrderDropDownWidgetState extends State<OrderDropDownWidget> {
  late final ValueNotifier<OrderStatus?> orderStatus =
  ValueNotifier<OrderStatus?>(null);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => OrderActionsViewModel(),),
      ChangeNotifierProvider(create: (context) => OrdersViewModel(),),
    ],
    child: Consumer<OrdersViewModel>(
      builder: (context, viewModel, child) {
        return Consumer<OrderActionsViewModel>(
          builder: (context, orderActionsViewModel, child) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(25.0)),
                gradient: LinearGradient(
                  colors: [Color(0xffFDFDFD), Color(0xffF4F7FF)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16),
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
                          value: orderActionsViewModel.orderStatus,
                          items: orderStatusMap.map((index, element) => MapEntry(
                            index,
                            DropdownMenuItem<String>(
                              onTap: () {
                                    (value) {
                                  orderActionsViewModel.orderStatus =
                                  orderStatusApiKeys[value];
                                  setState(() {
                                    orderActionsViewModel.orderStatus = orderStatusMap[index];
                                  });
                                };
                              },
                              value: element,
                              child: Text(
                                element.tr(),
                                style: const TextStyle(
                                  color: Color(0xFF464646),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.11,
                                ),
                              ),
                            ),
                          ),).values.toList(),
                          title: AppStrings.status.tr(),
                          onChanged: (value) {
                            setState(() {
                              orderActionsViewModel.orderStatus = value;
                              print(value);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if(orderActionsViewModel.isLoading)const Center(child: CircularProgressIndicator(),),
                    if(!orderActionsViewModel.isLoading) ButtonWidget(
                      onPressed: () {
                        if (orderActionsViewModel.orderStatus != null) {
                          orderActionsViewModel
                              .updateOrderStatus(
                              context, widget.orderId, widget.storeId)
                              .then(
                                (value) {
                              if (value == true) {
                                viewModel.orderDetails.status =
                                orderStatusMap[orderStatus.value];
                              }
                            },
                          );
                        }
                      },
                      isLoading: orderActionsViewModel.isLoading,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.s48,
                          vertical: AppSizes.s16),
                      title: AppStrings.completeTheOrder.tr(),
                      svgIcon: AppIcons.checkMarkDashed,
                    )
                  ],
                ),
              ),
            );
          },
        );
      } ,
    ),
    );
  }
}
