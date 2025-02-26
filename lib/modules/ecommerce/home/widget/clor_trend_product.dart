import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

class ClorTrendProduct extends StatelessWidget {
  const ClorTrendProduct({super.key});

  @override
  Widget build(BuildContext context) {
    print("DOES");
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child){
          return Padding(
            padding:LocalizationService.isArabic(context: context)? const EdgeInsets.only(right: 15) : const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(AppStrings.recommendedForYou.tr().toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xff1B1B1B),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,),
                      child: ListView.separated(
                          shrinkWrap: true,
                          reverse: false,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index)=> defaultViewProductGrid(
                              containerHeight: 240,
                              bookMark: true,
                              search: false,
                              value: homeProvider.checkResponse,
                              productId: homeProvider.colorTrendProducts[index]['id'],
                              productName: homeProvider.colorTrendProducts[index]['title'],
                              productType: homeProvider.colorTrendProducts[index]['category']['title'],
                              productPrice: "${homeProvider.colorTrendProducts[index]['price_after_discount']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              showSale: (homeProvider.colorTrendProducts[index]['price_after_discount'] != homeProvider.colorTrendProducts[index]['price_before_discount'])? true : false ,
                              showDiscount: (homeProvider.colorTrendProducts[index]['price_after_discount'] != homeProvider.colorTrendProducts[index]['price_before_discount'])? true : false ,
                              discountPrice: "${homeProvider.colorTrendProducts[index]['price_before_discount']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              productImageUrl: (homeProvider.colorTrendProducts[index]['main_cover'].isNotEmpty)?homeProvider.colorTrendProducts[index]['main_cover'][0]['file']:"",
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffC9CFD2).withOpacity(0.5),
                                  blurRadius: AppSizes.s5,
                                  spreadRadius: 1,
                                )
                              ],
                              onTap: (){
                                context.pushNamed(AppRoutes.ecommerceSingleProductDetailScreen.name,
                                    pathParameters: {'lang': context.locale.languageCode,
                                      'id' : "${homeProvider.colorTrendProducts[index]['id']}"});
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=> EcommerceSingleProductDetailScreen()));
                              }
                          ),
                          separatorBuilder: (context, index)=> const SizedBox(width: 10,),
                          itemCount: homeProvider.colorTrendProducts.length
                      ),
                    )
                )
              ],
            ),
          );
        }
    );
  }
}
