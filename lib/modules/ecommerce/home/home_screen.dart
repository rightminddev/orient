import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/home/widget/home_adds_widget.dart';
import 'package:orient/modules/ecommerce/home/widget/home_appbar_widget.dart';
import 'package:orient/modules/ecommerce/home/widget/home_best_offer_product.dart';
import 'package:orient/modules/ecommerce/home/widget/home_feature_widget.dart';
import 'package:orient/modules/ecommerce/home/widget/home_metal_points_product.dart';
import 'package:orient/modules/ecommerce/home/widget/home_poduct_view_widget.dart';
import 'package:orient/modules/ecommerce/home/widget/home_vocher_product_widget.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class ECommerceHomeScreen extends StatelessWidget {
  const ECommerceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeAppbarWidget(),
              const SizedBox(height: 30,),
              const HomePoductViewWidget(),
              const SizedBox(height: 20,),
              HomeFeatureWidget(),
              const SizedBox(height: 20,),
              const HomeMetalPointsProduct(),
              const SizedBox(height: 20,),
              const HomeBestOfferProduct(),
              const SizedBox(height: 20,),
              const HomeVocherProductWidget(),
              const SizedBox(height: 20,),
              HomeAddsWidget(),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
