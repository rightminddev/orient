import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

class HomePoductViewWidget extends StatelessWidget {
  const HomePoductViewWidget({super.key});

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
                                    'id' : '-1',
                                    'arrow' : "yes"
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
                              productId: homeProvider.products[index]['id'],
                              productName: homeProvider.products[index]['title'],
                              productType: homeProvider.products[index]['type']['value'],
                              productPrice: "${homeProvider.products[index]['price_after_discount']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              showSale: (homeProvider.products[index]['price_after_discount'] != homeProvider.products[index]['price_before_discount'])? true : false ,
                              showDiscount: (homeProvider.products[index]['price_after_discount'] != homeProvider.products[index]['price_before_discount'])? true : false ,
                              discountPrice: "${homeProvider.products[index]['price_before_discount']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              productImageUrl: (homeProvider.products[index]['main_cover'].isNotEmpty)?homeProvider.products[index]['main_cover'][0]['file']:"",
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
                          itemCount: homeProvider.products.length
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
