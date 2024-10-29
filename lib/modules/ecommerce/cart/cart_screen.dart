import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/cart/cart_screen_loading.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:orient/modules/ecommerce/cart/widget/cart_bottom_button_widget.dart';
import 'package:orient/modules/ecommerce/cart/widget/cart_enter_promo_widget.dart';
import 'package:orient/modules/ecommerce/cart/widget/cart_item_view_widget.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class ECommerceShoppingCart extends StatefulWidget {
  bool mainScreen = false;
  ECommerceShoppingCart({required this.mainScreen});
  @override
  State<ECommerceShoppingCart> createState() => _ECommerceShoppingCartState();
}

class _ECommerceShoppingCartState extends State<ECommerceShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> CartControllerProvider()..getCart(context: context),
    child: Consumer<CartControllerProvider>(
      builder: (context, value, child) {
        return  value.cartModel == null ?
        CartScreenLoading()
        :Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: Container(
              height: MediaQuery.sizeOf(context).height * 1,
                  child: GradientBgImage(
                                padding: EdgeInsets.zero,
                                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 90,
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Color(0xff224982)),
                                onPressed: () {
                                  if(widget.mainScreen == true){
                                    context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                                        pathParameters: {'lang': context.locale.languageCode});
                                  }else{
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              Text(
                                AppStrings.cart.tr().toUpperCase(),
                                style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                                  onPressed: (){}
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const CartItemViewWidget(),
                        const SizedBox(height: 20,),
                        CartEnterPromoWidget(),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/svg/vocher.svg"),
                            const SizedBox(width: 12,),
                            Text(
                              AppStrings.specialDiscountOnLargeQuantities.tr().toUpperCase(),
                              style: const TextStyle(
                                  color: Color(0xff1B1B1B),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                                ),
                              ),
                ),
            bottomNavigationBar: CartBottomButtonWidget()
        );
      },
    ),
    );
  }
}



