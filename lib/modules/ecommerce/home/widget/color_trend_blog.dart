import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class ColorTrendBlog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Color Blog",
              style: TextStyle(
                color: Color(0xff1B1B1B),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              ),
              Container(
                height: 144,
                padding:const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                    shrinkWrap: true,
                    reverse: false,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index)=> GestureDetector(
                      onTap: (){
                        context.pushNamed(AppRoutes.eCommerceSearchScreenView.name,
                            pathParameters: {'lang': context.locale.languageCode,
                              'id' : "${homeProvider.colorTrendBlog[index]['category_id']}"
                            });
                      },
                      child: Container(
                        height: 145,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    height: 102,
                                    width: 195,
                                    fit: BoxFit.cover,
                                    imageUrl:homeProvider.colorTrendBlog[index]['main_gallery'][0]['file'],
                                    placeholder: (context, url) =>
                                    const ShimmerAnimatedLoading(),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.image_not_supported_outlined,
                                      size: AppSizes.s32,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 11, left: 15),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        gradient: LinearGradient(
                                          colors: [Colors.transparent, Color(0xff1B1B1B).withOpacity(0.5)],
                                          begin: Alignment.center,
                                          end: Alignment.center,
                                        )
                                    ),
                                    child: Text(
                                      "Blog".toUpperCase(),
                                      style:const TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 8
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 130,
                              child: Text(
                                "${homeProvider.colorTrendBlog[index]['title']}".toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1B1B1B)
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text("see more".toUpperCase(),
                                  style:const TextStyle(
                                      color: Color(0xffE6007E),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                const Icon(Icons.arrow_forward, color: Color(0xffE6007E),size: 14,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index)=>const SizedBox(width: 14,),
                    itemCount: homeProvider.colorTrendBlog.length
                ),
              ),
            ],
          );
        }
    );
  }
}
