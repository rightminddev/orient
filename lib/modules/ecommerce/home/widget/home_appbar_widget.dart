import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/cart/controller/cart_controller.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';
import '../../../../utils/components/general_components/general_components.dart';

class HomeAppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Consumer<CartControllerProvider>(
            builder: (context, values, child) {
              return Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipRRect(
                      borderRadius:const BorderRadius.only(
                        bottomRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60)
                      ),
                      child: CachedNetworkImage(
                          imageUrl: homeProvider.coverImage!,
                          height: 360,
                          fit: BoxFit.cover,
                          placeholder: (context,
                              url) =>
                          const ShimmerAnimatedLoading(
                            circularRaduis:
                            AppSizes.s50,
                          ),
                          errorWidget: (context,
                              url, error) =>
                          const Icon(
                            Icons
                                .image_not_supported_outlined,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Consumer<HomeViewModel>(
                                  builder: (context, personalProfileViewModel, child) {
                                    print("----> ${personalProfileViewModel.userSettings!.userId}");
                                    return Expanded(
                                      child: defaultProfileContainer(
                                          imageUrl:(personalProfileViewModel.userSettings!.photo != null)?
                                          "${personalProfileViewModel.userSettings!.photo}" : '',
                                          userName:(personalProfileViewModel.userSettings!.name != null)?
                                          "${personalProfileViewModel.userSettings!.name}" : "",
                                          userRole:(personalProfileViewModel.userSettings!.role != null)?(personalProfileViewModel.userSettings!.role!.isNotEmpty)?
                                          "${personalProfileViewModel.userSettings!.role![0]}" : "" : "",
                                          context: context),
                                    );
                                  },
                                ),
                                Container(
                                  width: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            context.pushNamed(AppRoutes.notification.name,
                                                pathParameters: {'lang': context.locale.languageCode,});
                                          },
                                          child: SvgPicture.asset("assets/images/ecommerce/svg/notification.svg")),
                                      GestureDetector(
                                          onTap: (){
                                            if(values.cartModel!.cart!.items!.isNotEmpty){
                                              context.pushNamed(AppRoutes.eCommerceShoppingCartView.name,
                                                  pathParameters: {'lang': context.locale.languageCode});
                                            }
                                          },
                                          child: SvgPicture.asset("assets/images/ecommerce/svg/cart.svg")),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 35),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: 70,
                                  child: SvgPicture.asset("assets/images/ecommerce/svg/ecommerce_home_logo.svg", color: Colors.transparent,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Image.asset(
                                    "assets/images/ecommerce/png/logo_name.png",
                                    width: 200,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 115,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: (){
                                    context.pushNamed(AppRoutes.eCommerceSearchScreenView.name,
                                        pathParameters: {'lang': context.locale.languageCode,
                                          'id' : "${homeProvider.productsCategories[index]['id']}"
                                        });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          imageUrl: homeProvider.productsCategories[index]['image'][0]['thumbnail'],
                                          placeholder: (context, url) =>
                                          const ShimmerAnimatedLoading(),
                                          errorWidget: (context, url, error) => const Icon(
                                            Icons.image_not_supported_outlined,
                                            size: AppSizes.s32,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${homeProvider.productsCategories[index]['title']}".toUpperCase(),
                                        style:const TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) =>const SizedBox(width: 10),
                                itemCount: homeProvider.productsCategories.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
        );
      },
    );
  }
}
