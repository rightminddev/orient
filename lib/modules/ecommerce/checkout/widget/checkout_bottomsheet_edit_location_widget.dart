import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/widget/edit_create_addreess.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class CheckoutBottomsheetEditLocationWidget extends StatefulWidget {
  bool addAdress;
  var countryIdModel;
  var countryCodeModel;
  var phoneModel;
  var addressModel;
  var stateIdModel;
  var cityIdModel;
  var id;
  CheckoutBottomsheetEditLocationWidget({super.key,
      required this.addAdress,
      this.countryIdModel,
      this.countryCodeModel,
      this.phoneModel,
      this.addressModel,
      this.stateIdModel,
      this.cityIdModel,
      this.id});
  @override
  State<CheckoutBottomsheetEditLocationWidget> createState() => _CheckoutBottomsheetEditLocationWidgetState();
}

class _CheckoutBottomsheetEditLocationWidgetState extends State<CheckoutBottomsheetEditLocationWidget> {
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckoutControllerProvider(),
      child: Consumer<CheckoutControllerProvider>(
        builder: (context, value, child) {
          print("STATE ID -> ${widget.stateIdModel}");
          if (value.isAddAddressSuccess == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CheckConst.userAddressModel!.id = widget.id;
              value.updateCart(
                  context: context,
                  address_id: CheckConst.userAddressModel!.id,
                  payment_method_id: CheckConst.selectedPaymentId);
              Navigator.pop(context);
              value.isAddAddressSuccess = false;
            });
          }
          if (value.isUpdateAddressSuccess == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CheckConst.userAddressModel!.id = widget.id;
              value.updateCart(
                  context: context,
                  address_id: CheckConst.userAddressModel!.id,
                  payment_method_id: CheckConst.selectedPaymentId);
              Navigator.pop(context);
              value.isUpdateAddressSuccess = false;
            });
          }
          return Consumer<HomeViewModel>(
            builder: (context, values, child) {
              return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                    color: Color(0xffFFFFFF)
                ),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.75,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      Center(
                        child:Container(
                          width: 63,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Color(0xffB9C0C9),
                              borderRadius: BorderRadius.circular(100)
                          ),
                        ) ,
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: CreateEditAddressScreen(
                          addAdress: widget.addAdress,
                          id: widget.id,
                          addressModel:widget.addressModel ,
                          cityIdModel: widget.cityIdModel,
                          countryCodeModel: widget.countryCodeModel,
                          countryIdModel:widget.countryIdModel,
                          phoneModel: widget.phoneModel,
                          stateIdModel: widget.stateIdModel,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
   
  }

}
