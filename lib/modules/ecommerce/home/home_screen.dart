import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/bookmark/controller/bookmark_controller.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/home/home_screen_loading.dart';
import 'package:orient/modules/ecommerce/home/widget/home_adds_widget.dart';
import 'package:orient/modules/ecommerce/home/widget/home_best_offer_product.dart';
import 'package:orient/modules/ecommerce/home/widget/home_feature_widget.dart';
import 'package:orient/modules/ecommerce/home/widget/home_metal_points_product.dart';
import 'package:orient/modules/ecommerce/home/widget/home_poduct_view_widget.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:provider/provider.dart';
import 'package:orient/modules/ecommerce/home/widget/home_appbar_widget.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'widget/home_vocher_product_widget.dart';

class ECommerceHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> HomeProvider()..getPages(context: context, fromHome: true)..getColorTrend(context: context),),
      ChangeNotifierProvider(create: (context)=> CartControllerProvider()..getCart(context: context),),
      ChangeNotifierProvider(create: (context)=> HomeViewModel()..initializeHomeScreen(context),),
      ChangeNotifierProvider(create: (context)=> BookmarkControllerProvider(),)
    ],
    child: Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if(homeProvider.isSuccess == true){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            homeProvider.getCheck(context: context, ids: HomeConst.Ids);
          });
          homeProvider.isSuccess = false;
        }
        return Consumer<BookmarkControllerProvider>(
            builder: (context, bookmarkControllerProvider, child) {

              return Consumer<HomeViewModel>(builder:
                  (context, value, child) {
                return Scaffold(
                    backgroundColor: Color(0xffFFFFFF),
                    body: (!homeProvider.isLoading && value.userSettings != null)
                        ? GradientBgImage(
                      padding: EdgeInsets.zero,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            HomeAppbarWidget(),
                            const SizedBox(height: 20,),
                            const HomePoductViewWidget(),
                            const SizedBox(height: 20,),
                            HomeFeatureWidget(),
                            const SizedBox(height: 20,),
                            const HomeMetalPointsProduct(),
                            const SizedBox(height: 40,),
                            const HomeVocherProductWidget(),
                            const SizedBox(height: 20,),
                            HomeAddsWidget(),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    )
                        :  SingleChildScrollView(
                      child: GradientBgImage(
                          padding: EdgeInsets.zero,
                          child: HomeScreenLoading()),
                    )

                );
              },
              );
            },
        );
      },
    ),
    );
  }
}