import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class CheckoutBottomsheetEditLocationWidget extends StatefulWidget {
  const CheckoutBottomsheetEditLocationWidget({super.key});

  @override
  State<CheckoutBottomsheetEditLocationWidget> createState() => _CheckoutBottomsheetEditLocationWidgetState();
}

class _CheckoutBottomsheetEditLocationWidgetState extends State<CheckoutBottomsheetEditLocationWidget> {
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutControllerProvider>(
      builder: (context, value, child) {
        if (value.isAddAddressSuccess == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            value.isAddAddressSuccess = false;
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
              child: Column(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        defaultTextFormField(hintText: AppStrings.phone.tr().toUpperCase(), containerHeight: 64, controller: value.phoneController),
                        defaultTextFormField(hintText: AppStrings.address.tr().toUpperCase(), containerHeight: 64, controller:value.addressController),
                        defaultTextFormField(hintText: AppStrings.country.tr().toUpperCase(), containerHeight: 64),
                        defaultTextFormField(hintText: AppStrings.stateProvinceRegion.tr().toUpperCase(), containerHeight: 64),
                        defaultTextFormField(hintText: AppStrings.city.tr().toUpperCase(), containerHeight: 64),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if(value.isAddAddressLoading)const CircularProgressIndicator(),
                  if(!value.isAddAddressLoading) Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ButtonWidget(
                        onPressed: (){
                          value.addAddressCheckout(
                              context: context,
                              phone: value.phoneController,
                              address: value.addressController,
                              user_id: values.userSettings!.userId,
                              state_id: '1',
                              city_id: '1',
                              country_key: '20',
                              country_id: '1'
                          );
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        svgIcon: "assets/images/ecommerce/svg/verifiy.svg",
                        title: AppStrings.saveChanges.tr().toUpperCase()
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
   
  }

}
