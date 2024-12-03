import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class SearchCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child){
          return  Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 115,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    context.pushNamed(AppRoutes.eCommerceSearchScreenView.name,
                        pathParameters: {'lang': context.locale.languageCode,
                          'id' : "${homeProvider.productsCategories[index]['id']}",
                          'arrow' : "yes"
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
          );
    }
    );
  }
}
