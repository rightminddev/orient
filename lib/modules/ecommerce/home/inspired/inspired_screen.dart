import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/home/inspired/inspired_screen_loading.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/components/general_components/view_image_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class InspiredScreen extends StatefulWidget {
  @override
  State<InspiredScreen> createState() => _InspiredScreenState();
}

class _InspiredScreenState extends State<InspiredScreen> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => HomeProvider()..getInspiredCategory(context: context)..getInspired(context: context, inspired_categories: 1),
    child: Consumer<HomeProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          appBar: AppBar(
            backgroundColor: const Color(0xffFFFFFF),
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
            title: Text(
              AppStrings.getInspired.tr().toUpperCase(),
              style: const TextStyle(
                  fontSize: AppSizes.s16,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF224982)),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFFF007A).withOpacity(0.03),
                    const Color(0xFF00A1FF).withOpacity(0.03)
                  ],
                ),),
            ),
          ),
          body: GradientBgImage(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                if(value.isInspiredCategoryLoading)InspiredCategoryShimmerLoading(),
                if(!value.isInspiredCategoryLoading)Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: 36,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (){
                            setState(() {
                              selectIndex = index;
                            });
                            value.getInspired(context: context, inspired_categories: value.inspiredCategories[index]['id']);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: (selectIndex == index)? const Color(0xffE6007E):const Color(0xff6F6F6E).withOpacity(0.1)
                            ),
                            child: Text(value.inspiredCategories[index]['title'], style: TextStyle(fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: (selectIndex == index)? const Color(0xffFFFFFF):const Color(0xff1B1B1B)
                            ),),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const SizedBox(width: 10,),
                        itemCount: value.inspiredCategories.length
                    ),
                  ),
                ),
                const SizedBox(height: 25,),
                if(value.isInspiredLoading)InspiredGaleryShimmerLoading(),
                if(!value.isInspiredLoading)Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                child: defaultViewImageGallery(listImagesUrl: value.inspireds, url: true ),
                )
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
