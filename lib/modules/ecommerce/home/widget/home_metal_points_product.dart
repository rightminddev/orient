import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

class HomeMetalPointsProduct extends StatelessWidget {
  const HomeMetalPointsProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  reverse: false,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index)=>Column(
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${homeProvider.moreProducts[index]['title']}".toUpperCase(),
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
                                          'id' : "${homeProvider.moreProducts[index]['id']}"
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
                                itemBuilder: (context, indexs)=> defaultViewProductGrid(
                                    containerHeight: 240,
                                    productName: homeProvider.moreProducts[index]['products'][indexs]['title'],
                                    productType: homeProvider.moreProducts[index]['products'][indexs]['type']['value'],
                                    productPrice: "${homeProvider.moreProducts[index]['products'][indexs]['price']} EGP",
                                    showSale: (homeProvider.moreProducts[index]['products'][indexs]['sell_price'] != null)? true : false ,
                                    showDiscount: (homeProvider.moreProducts[index]['products'][indexs]['sell_price'] != null)? true : false ,
                                    discountPrice: "${homeProvider.moreProducts[index]['products'][indexs]['regular_price']} EGP",
                                    productImageUrl: (homeProvider.moreProducts[index]['products'][indexs]['main_cover'].isNotEmpty)?homeProvider.products[index]['main_cover'][0]['file']:"",
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
                                            'id' : "${homeProvider.moreProducts[index]['products'][indexs]['id']}"});
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=> EcommerceSingleProductDetailScreen()));
                                    }
                                ),
                                separatorBuilder: (context, index)=> const SizedBox(width: 10,),
                                itemCount: homeProvider.moreProducts[index]['products'].length
                            ),
                          )
                      )
                    ],
                  ),
                  separatorBuilder: (context, index)=> SizedBox(height: 20,),
                  itemCount: homeProvider.moreProducts.length
              )
          );
        },
    );
  }
}
