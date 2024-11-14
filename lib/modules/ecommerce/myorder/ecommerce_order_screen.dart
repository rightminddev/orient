import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/myorder/model/ecommerce_order_details_model.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/button_widget.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import 'widget/get_myorder_loading.dart';

class EcommerceOrderScreen extends StatelessWidget {
  const EcommerceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => EcommerceOrderDetailsModel()..getMyOrder(context),
    child: Consumer<EcommerceOrderDetailsModel>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          appBar: AppBar(
            backgroundColor: const Color(0xffFFFFFF),
            title: Text(
              AppStrings.myOrders.tr().toUpperCase(),
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
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child:(!value.isLoading)? ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        reverse: false,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) => (value.myOrders[index]['status'] != "processing")?Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffC9CFD2).withOpacity(0.5),
                                blurRadius: AppSizes.s5,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${AppStrings.orderNo.tr()} ${value.myOrders[index]['uuid']}", style: const TextStyle(color: Color(AppColors.oc2), fontSize: 15, fontWeight: FontWeight.w400),),
                              const SizedBox(height: 15,),
                              RichText(
                                text: TextSpan(
                                  text: "${AppStrings.date.tr()}: ",
                                  style: const TextStyle(color: Color(AppColors.oc2), fontSize: 15, fontWeight: FontWeight.w700),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "${value.myOrders[index]['date']}",
                                      style: const TextStyle(
                                        color: Color(0xff464646),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                              RichText(
                                text: TextSpan(
                                  text: "${AppStrings.totalAmount.tr()}: ",
                                  style: TextStyle(color: Color(AppColors.oc2), fontSize: 15, fontWeight: FontWeight.w700),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "${value.myOrders[index]['total']} EGP",
                                      style: const TextStyle(
                                        color: Color(0xff464646),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonWidget(
                                    buttonWidth: MediaQuery.sizeOf(context).width * 0.2,
                                    onPressed: () {
                                      context.pushNamed(AppRoutes.eCommerceMyOrderDetailsScreen.name,
                                          pathParameters: {'lang': context.locale.languageCode,
                                            'id' : "${value.myOrders[index]['id']}"
                                          });
                                    },
                                    borderSide:
                                    const BorderSide(width: 1, color: Color(AppColors.oc1)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.s48, vertical: AppSizes.s16),
                                    title: AppStrings.details.tr().toUpperCase(),
                                    fontColor: const Color(AppColors.oc1),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Text(value.myOrders[index]['status'].toUpperCase(), style: const TextStyle(color: Color(0xff2AA952), fontSize: 14, fontWeight: FontWeight.w500),),
                                ],
                              )
                            ],
                          ),
                        ):const SizedBox(height: 0.0,),
                        separatorBuilder: (context, index) => const SizedBox(height: 24,),
                        itemCount: value.myOrders.length
                    ):ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        reverse: false,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) => const GetMyorderLoading(),
                        separatorBuilder: (context, index) => const SizedBox(height: 24,),
                        itemCount: 4
                    ),
                  ),
                ),
              )
          ),
        );
      },
    ),
    );
  }
}
