import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/modules/ecommerce/checkout/controller/checkout_controller.dart';
import 'package:orient/modules/ecommerce/checkout/controller/cosnts.dart';
import 'package:orient/modules/ecommerce/checkout/widget/checkout_bottomsheet_edit_location_widget.dart';
import 'package:orient/modules/ecommerce/checkout/widget/edit_create_addreess.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
        title: Text(
          AppStrings.shippingAddress.tr().toUpperCase(),
          style: const TextStyle(
              fontSize: AppSizes.s16,
              fontWeight: FontWeight.w700,
              color: Color(0XFF224982)),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFFFF007A).withOpacity(0.03),
                const Color(0xFF00A1FF).withOpacity(0.03)
              ],
            ),),
        ),
      ),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: ChangeNotifierProvider(
                create: (context)=>CheckoutControllerProvider()..getShippingAddress(context: context),
                child: Consumer<CheckoutControllerProvider>(
                  builder: (context, value, child) {
                    return Consumer<HomeViewModel>(
                      builder: (context, values, child) {
                        print("REBUILD AGAIN");
                        return (value.isShippingAddressLoading)?
                        SingleChildScrollView(
                          child: HomeLoadingPage(viewAppbar: false,),
                        )
                            :Container(
                              height: MediaQuery.sizeOf(context).height * 0.8,
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
                                    },
                                    location: value.addressModel!.data![index].address,
                                    onTapEdit: ()async{
                                      await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                                        ),
                                        builder: (BuildContext context) {
                                          return CheckoutBottomsheetEditLocationWidget(
                                            addAdress: false,
                                            checkout: false,
                                            stateIdModel:value.addressModel!.data![index].stateId,
                                            phoneModel: value.addressModel!.data![index].phone,
                                            countryIdModel: value.addressModel!.data![index].countryId,
                                            countryCodeModel:value.addressModel!.data![index].countryKey ,
                                            cityIdModel:value.addressModel!.data![index].cityId,
                                            id: value.addressModel!.data![index].id,
                                            addressModel:value.addressModel!.data![index].address,
                                          );
                                        },
                                      );
                                      value.getShippingAddress(context: context);
                                    }
                                ),
                                itemCount: value.addressModel!.data!.length,
                              ),
                            );
                      },
                    );
                  },
                ),
              ),
            ),
          )
      ),
    );
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
