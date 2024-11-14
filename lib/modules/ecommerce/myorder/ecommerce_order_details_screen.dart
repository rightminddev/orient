import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_theme.service.dart';
import 'package:orient/modules/ecommerce/myorder/model/ecommerce_order_details_model.dart';
import 'package:orient/modules/ecommerce/myorder/widget/get_order_details_loading.dart';
import 'package:orient/modules/ecommerce/myorder/widget/order_details_list_order.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_sizes.dart';

class EcommerceOrderDetailsScreen extends StatelessWidget {
  var id;
   EcommerceOrderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => EcommerceOrderDetailsModel()..getMyOrderDetails(context, id),
    child: Consumer<EcommerceOrderDetailsModel>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          appBar: AppBar(
            backgroundColor: const Color(0xffFFFFFF),
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
            title: Text(
              AppStrings.orderDetails.tr().toUpperCase(),
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
            child: (value.orderDetailsModel == null)?
            const GetOrderDetailsLoading()
            :SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${AppStrings.orderNo.tr()} ${value.orderDetailsModel!.order!.uuid}',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                              color: AppThemeService
                                  .colorPalette.secondaryTextColor.color,
                              height: 0,
                              letterSpacing: 0,
                            ),
                          ),
                          const Spacer(),
                          Text(value.orderDetailsModel!.order!.status!.toUpperCase(), style: const TextStyle(color: Color(0xff2AA952), fontSize: 14, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      OrderDetailsListOrder(items: value.orderDetailsModel!.order!.items,),
                      const SizedBox(height: 30,),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(AppStrings.orderInformation.tr().toUpperCase(), style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14, color: Color(AppColors.oc2)
                        ),),
                      ),
                      const SizedBox(height: 15,),
                      defaultOrderInfo("${AppStrings.date.tr()}:", "${value.orderDetailsModel!.order!.date}",context),
                      defaultOrderInfo("${AppStrings.shippingAddress.tr()}:", "${value.orderDetailsModel!.order!.shippingInfo!.addressText}",context),
                      defaultOrderInfo("${AppStrings.paymentMethods.tr()}:", "${value.orderDetailsModel!.order!.paymentGateway!.title}",context),
                      defaultOrderInfo("${AppStrings.shippingCost.tr()}:", "${value.orderDetailsModel!.order!.shippingCost}",context),
                      defaultOrderInfo("${AppStrings.totalAmount.tr()}:", "${value.orderDetailsModel!.order!.total}", context),
                      const SizedBox(height: 25,),
                      ButtonWidget(
                        title: AppStrings.needHelp.tr().toUpperCase(),
                        svgIcon: "assets/images/svg/info.svg",
                        onPressed: () {
                        },
                        padding: EdgeInsets.zero,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
  Widget defaultTextTitle(title)=>Text(title.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(AppColors.gray1)),);
  Widget defaultTextDescription(description)=>Text(description.toUpperCase(),textAlign: TextAlign.end, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(AppColors.gray1)),);
  Widget defaultOrderInfo(title,description,context)=>Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.sizeOf(context).width * 0.3,
            child: defaultTextTitle(title)),
        Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: defaultTextDescription(description))
      ],
    ),
  );
}
