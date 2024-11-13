import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class HomeVocherProductWidget extends StatelessWidget {
  const HomeVocherProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder:
    (context, value, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 170,
          width: 320,
          child: ListView.separated(
            shrinkWrap: true,
              reverse: false,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  context.pushNamed(AppRoutes.ecommerceSingleProductDetailScreen.name,
                      pathParameters: {'lang': context.locale.languageCode,
                        'id' : "${value.premiumProductImage[index]['id']}"});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                        imageUrl: value.premiumProductImage[index]['sizes']['large'],
                        width: 320,
                        height: 170,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        const ShimmerAnimatedLoading(
                          circularRaduis: AppSizes.s50,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                        )),
                  ),
                ),
              ),
              separatorBuilder: (context, index)=> const SizedBox(width: 20,),
              itemCount: value.premiumProductImage.length
          ),
        )
        // child: Stack(
        //   alignment: Alignment.topRight,
        //   children: [
        //     Container(
        //       width: double.infinity,
        //       height: 200,
        //       padding: EdgeInsets.only(top: 55),
        //       child: Container(
        //         padding: EdgeInsets.all(10),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15),
        //           color: Colors.white,
        //           gradient: LinearGradient(
        //             begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //             colors: [
        //               const Color(0xff584330),
        //               const Color(0xffAA845F),
        //             ],
        //           ),
        //         ),
        //         child: Container(
        //           padding: EdgeInsets.only(left: 10),
        //           decoration: BoxDecoration(
        //               color: Colors.transparent,
        //               borderRadius: BorderRadius.circular(15),
        //               border: Border.all(color: const Color(0xffFFFFFF))
        //           ),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Container(
        //                 width: 160,
        //                 height: 12,
        //                 child: Text("wall Paints".toUpperCase(),
        //                   maxLines: 1,
        //                   style:const TextStyle(
        //                     color: Color(0xffFFFFFF),
        //                     fontWeight: FontWeight.w400,
        //                     fontSize: 8,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(height: 5,),
        //               Container(
        //                 width: 140,
        //                 // height: 30,
        //                 child: Text("HIGH PLAST SILK 787".toUpperCase(),
        //                   maxLines: 2,
        //                   style:const TextStyle(
        //                     color: Color(0xffFFFFFF),
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //               ),
        //               const SizedBox(height: 25,),
        //               Row(
        //                 children: [
        //                   Text("see more".toUpperCase(),
        //                     style:const TextStyle(
        //                         color: Color(0xffFFFFFF),
        //                         fontSize: 10,
        //                         fontWeight: FontWeight.w400
        //                     ),
        //                   ),
        //                   const SizedBox(width: 5,),
        //                   const Icon(Icons.arrow_forward, color: Color(0xffFFFFFF),size: 14,)
        //                 ],
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     Image.asset("assets/images/ecommerce/png/brown_paint.png",
        //       height: 180,
        //       width: 180,
        //     )
        //   ],
        // ),
      );
    },
    );
  }
}
