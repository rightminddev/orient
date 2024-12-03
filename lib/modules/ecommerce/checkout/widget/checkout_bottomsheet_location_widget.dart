import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottomsheet_edit_location_widget.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:provider/provider.dart';

class CheckoutBottomsheetLocationWidget extends StatefulWidget {
  @override
  State<CheckoutBottomsheetLocationWidget> createState() => _CheckoutBottomsheetLocationWidgetState();
}

class _CheckoutBottomsheetLocationWidgetState extends State<CheckoutBottomsheetLocationWidget> {
 int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CheckoutControllerProvider()..getAddressCheckout(context: context),
      child: Consumer<CheckoutControllerProvider>(
        builder: (context, value, child) {
          return Consumer<HomeViewModel>(
            builder: (context, values, child) {
              print("REBUILD AGAIN");
              return (value.isGetAddressLoading || value.isUpdateCartLoading)?
              SingleChildScrollView(
                child: HomeLoadingPage(viewAppbar: false,),
              )
                  :Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                    color: Color(0xffFFFFFF)
                ),
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.8,
                alignment: Alignment.topCenter,
                child: Column(
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
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.62,
                            child: ListView.separated(
                              separatorBuilder: (context, index)=> const SizedBox.shrink(),
                              itemBuilder: (context, index)=> defaultLocationContainer(
                                  context: context,
                                  use: (selectIndex == index + 1) ? true : false,
                                  onTap: (){
                                    if(selectIndex == index + 1){
                                      print("yes");
                                      setState(() {
                                        selectIndex = 0;
                                        print(selectIndex);
                                      });
                                    }else{
                                      setState(() {
                                        selectIndex = index+1;
                                        print(selectIndex);
                                      });
                                    }
                                    CheckConst.userAddressModel!.address = value.shippingAddresses[index]['address'];
                                    CheckConst.userAddressModel!.id = value.shippingAddresses[index]['id'];
                                    print("CheckConst.selectedPaymentId -> ${CheckConst.selectedPaymentId}");
                                    CheckConst.selectedAddressId = value.shippingAddresses[index]['id'];
                                    value.updateCart(
                                        context: context,
                                        address_id: CheckConst.selectedAddressId,
                                        payment_method_id: CheckConst.selectedPaymentId);
                                  },
                                  location: value.shippingAddresses[index]['address'],
                                  onTapEdit: ()async{
                                    CheckConst.userAddressModel!.id = value.shippingAddresses[index]['id'];
                                    await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                                      ),
                                      builder: (BuildContext context) {
                                        return CheckoutBottomsheetEditLocationWidget(
                                          addAdress: false,
                                          stateIdModel:value.shippingAddresses[index]['state_id'],
                                          phoneModel: value.shippingAddresses[index]['phone'],
                                          countryIdModel: value.shippingAddresses[index]['country_id'],
                                          countryCodeModel:value.shippingAddresses[index]['country_key'] ,
                                          cityIdModel:value.shippingAddresses[index]['city_id'],
                                          id: value.shippingAddresses[index]['id'],
                                          addressModel:value.shippingAddresses[index]['address'],
                                        );
                                      },
                                    );
                                    Navigator.pop(context);
                                  }
                              ),
                              itemCount: value.shippingAddresses.length,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          ButtonWidget(
                            title: AppStrings.addAddress.tr().toUpperCase(),
                            svgIcon: "assets/images/ecommerce/svg/add.svg",
                            onPressed: ()async{
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                                ),
                                builder: (BuildContext context) {
                                  return CheckoutBottomsheetEditLocationWidget(
                                    addAdress: true,

                                  );
                                },
                              );
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );

    //   ChangeNotifierProvider(create: (context)=> CheckoutControllerProvider()..getPrepareCheckout(context: context),
    // child:
    // );
  }

  Widget defaultLocationContainer({context,location, bool use = false, void Function()? onTap, void Function()? onTapEdit})=>  GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.s8),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s25, horizontal: AppSizes.s12),
      decoration: ShapeDecoration(
        color: AppThemeService.colorPalette.tertiaryColorBackground.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/images/ecommerce/svg/checkout_location.svg"),
              const SizedBox(width: 10,),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child:  Text(location,
                  style:const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff1B1B1B)
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: onTapEdit,
                child: Text(AppStrings.edit.tr().toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffE6007E)
                  ),
                ),
              ),
            ],
          ),
          if(use == true) const SizedBox(height: 15,),
          if(use == true)Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Container(
              width: 170,
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffE6007E)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const CircleAvatar(
                    radius: 10,
                    backgroundColor: Color(0xff38CF71),
                    child: Icon(
                      Icons.check,
                      color: Color(0xffFFFFFF),
                      size: 12,
                    ),
                  ),
                  Text(AppStrings.addAddress.tr().toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xffFFFFFF),
                    fontWeight:FontWeight.w500,
                    fontSize: 12
                  ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
