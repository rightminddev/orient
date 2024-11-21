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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.recommendedForYou.tr().toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xff1B1B1B),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              context.pushNamed(AppRoutes.eCommerceSearchScreenView.name,
                                  pathParameters: {'lang': context.locale.languageCode,
                                    'id' : '-1'
                                  });
                            },
                            child: Text(AppStrings.seeMore.tr().toUpperCase(),
                              style:const TextStyle(
                                  color: Color(0xff1B1B1B),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Icon(Icons.arrow_forward, color: Color(0xff1B1B1B),size: 14,)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 240,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,),
                      child: ListView.separated(
                          shrinkWrap: true,
                          reverse: false,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index)=> defaultViewProductGrid(
                              containerHeight: 240,
                              bookMark: true,
                              search: false,
                              value: homeProvider.checkResponse,
                              productId: homeProvider.colorTrendProducts[index]['id'],
                              productName: homeProvider.colorTrendProducts[index]['title'],
                              productType: homeProvider.colorTrendProducts[index]['type']['value'],
                              productPrice: "${homeProvider.colorTrendProducts[index]['price']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              showSale: (homeProvider.colorTrendProducts[index]['sell_price'] != null)? true : false ,
                              showDiscount: (homeProvider.colorTrendProducts[index]['sell_price'] != null)? true : false ,
                              discountPrice: "${homeProvider.colorTrendProducts[index]['regular_price']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
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
                                      'id' : "${homeProvider.products[index]['id']}"});
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
