import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/modules/ecommerce/home/color_trend/color_trend_loading.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/home/widget/clor_trend_product.dart';
import 'package:orient/modules/ecommerce/home/widget/color_trend_appbar_widget.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/utils/components/general_components/gallery_slider_image.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/components/general_components/view_image_gallery.dart';
import 'package:provider/provider.dart';

import '../widget/color_trend_blog.dart';

class ColorTrendScreen extends StatelessWidget {
  const ColorTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> HomeProvider()..getColorTrend(context: context),
    child: Consumer<HomeProvider>(
      builder: (context, value, child) {
        if(value.isColorTrendSuccess == true){
          print("CONTENT IS ----> ${value.colorTrendContant}");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            value.getCheck(context: context, ids: HomeConst.Ids);
          });
          value.isColorTrendSuccess = false ;
        }
       return Scaffold(
          body: (value.isColorTrendLoading)?
          const ColorTrendLoading()
          :GradientBgImage(
            padding: EdgeInsets.zero,
            child: Container(
              height: MediaQuery.sizeOf(context).height *1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ColorTrendAppbarWidget(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Html(
                          data: value.colorTrendContant,
                          style: {
                            "p": Style(
                              color: Color(0xff525252),
                              lineHeight: LineHeight(1.5),
                              fontSize: FontSize(14), // Adjust font size for better visibility
                              fontWeight: FontWeight.w400,
                            ),
                          }),
                    ),
                    const SizedBox(height: 20,),
                    defaultViewImageGallery(listImagesUrl: value.colorTrendGallery,),
                    const SizedBox(height: 10,),
                    const ClorTrendProduct(),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        height: 180,
                        child: ColorTrendBlog(),
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          )
        );
      },
    ),
    );
  }
}
