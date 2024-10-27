import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/home/widget/claculate_show_dialog.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class HomeFeatureWidget extends StatelessWidget {
  List feature = [
    {
      "image" : "assets/images/ecommerce/png/c-trend.png",
      "title" : "color trends"
    },{
      "image" : "assets/images/ecommerce/png/g-inispired.png",
      "title" : "Get inspired"
    },{
      "image" : "assets/images/ecommerce/png/calculate.png",
      "title" : "calculator"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child){
         return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 115,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: ()async{
                    print(index);
                    if(index == 0){
                      print(index);
                      await context.pushNamed(AppRoutes.eCommerceColorTrendScreen.name,
                          pathParameters: {'lang': context.locale.languageCode,});
                    }
                    if(index == 1){
                      print(index);
                      await context.pushNamed(AppRoutes.eCommerceGetInspiredScreen.name,
                          pathParameters: {'lang': context.locale.languageCode,});
                    }
                    if(index == 2){
                      print(index);
                     await showDialog(
                         context: context,
                         builder: (BuildContext context) {
                         return showCalculateDialog(
                             context: context,
                             value: homeProvider.selectCategory,
                             controller: homeProvider.numberOfMetersController);
                     },
                     );
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(115),
                        child: Image.asset("${feature[index]['image']}",
                          width: 115,
                          height: 115,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 115,
                        padding:const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "${feature[index]['title']}".toUpperCase(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) =>const SizedBox(width: 0),
                itemCount: feature.length,
              ),
            ),
          );
        }
    );
  }
}
