import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/search/controller/search_controller.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/pagination_widget.dart';
import 'package:provider/provider.dart';

class SearchProductGridviewWidget extends StatelessWidget {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, value, child) {
          return Consumer<SearchControllerProvider>(
            builder: (context, searchControllerProvider, child){

              if(searchControllerProvider.isSuccessSearch == true){
                print("A7A");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  value.getCheck(context: context, ids: HomeConst.Ids);
                });
                searchControllerProvider.isSuccessSearch = false;
              }
              if (searchControllerProvider.isLoadingSearch && searchControllerProvider.pageNumber == 1) {
                return HomeLoadingPage(viewAppbar: false);
              } else if (searchControllerProvider.searchProduct.isEmpty) {
                return Center(child: Text('No products found.'));
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    reverse: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: .7,
                    ),
                    itemBuilder: (context, index){
                      return  defaultViewProductGrid(
                          bookMark:  true,
                          search: true,
                          productId: searchControllerProvider.searchProduct[index]['id'],
                          productName: searchControllerProvider.searchProduct[index]['title'],
                          productType: searchControllerProvider.searchProduct[index]['type'],
                          productPrice: "${searchControllerProvider.searchProduct[index]['price']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                          discountPrice: "${searchControllerProvider.searchProduct[index]['regular_price']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                          showSale: (searchControllerProvider.searchProduct[index]['sell_price'] != null)? true : false ,
                          showDiscount: (searchControllerProvider.searchProduct[index]['sell_price'] != null)? true : false ,
                          productImageUrl: searchControllerProvider.searchProduct[index]['main_cover'][0]['file'],
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffC9CFD2).withOpacity(0.5),
                              blurRadius: AppSizes.s8,
                              spreadRadius: 1,
                            )
                          ],
                          onTap: (){
                            print("ID IS ---> ${searchControllerProvider.searchProduct[index]['id']}");
                            context.pushNamed(AppRoutes.ecommerceSingleProductDetailScreen.name,
                                pathParameters: {'lang': context.locale.languageCode,
                                  'id' : "${searchControllerProvider.searchProduct[index]['id']}"});
                          }
                      );
                    },
                    itemCount: searchControllerProvider.searchProduct.length,
                  ),
                );
              }
            },
          );
        },);
  }
}
