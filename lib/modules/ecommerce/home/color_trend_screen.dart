import 'package:flutter/material.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/home/widget/color_trend_appbar_widget.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/utils/components/general_components/gallery_slider_image.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/components/general_components/view_image_gallery.dart';
import 'package:provider/provider.dart';

import 'widget/color_trend_blog.dart';

class ColorTrendScreen extends StatelessWidget {
  const ColorTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> HomeProvider()..getColorTrend(context: context),
    child: Consumer<HomeProvider>(
      builder: (context, value, child) {
       return Scaffold(
          body: (value.isColorTrendLoading)?
          HomeLoadingPage(
            viewAppbar: false,
          )
          :GradientBgImage(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ColorTrendAppbarWidget(),
                  const SizedBox(height: 20,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        value.colorTrendContant,
                        textAlign: TextAlign.center,
                        style:const TextStyle(
                          color: Color(0xff525252),
                          height: 24/12,
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  defaultViewImageGallery(listImagesUrl: value.colorTrendGallery,),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 240,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:const Center(
                        child: Text(
                            "NO PRODUCT FOUND"
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 180,
                      child: ColorTrendBlog(),
                    ),
                  )
                ],
              ),
            ),
          )
        );
      },
    ),
    );
  }
}
