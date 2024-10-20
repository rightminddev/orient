import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/modules/ecommerce/search/widget/search_category_widget.dart';
import 'package:orient/modules/ecommerce/search/widget/search_filter_widget.dart';
import 'package:orient/modules/ecommerce/search/widget/search_product_gridview_widget.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class ECommerceSearchScreen extends StatelessWidget {
  const ECommerceSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "shop".toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xff224982)
          ),
        ),
        leading: Icon(Icons.arrow_back, color: const Color(0xff0D3B6F),),
        actions:[ Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: ()async{
              return await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35.0)),
                ),
                builder: (BuildContext context) {
                  return const SearchFilterWidget();
                },
              );
            },
            child: Container(
              width: 32,
                height: 32,
                padding:const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffE6007E),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: SvgPicture.asset("assets/images/ecommerce/svg/fliter.svg")),
          ),
        ),]
      ),
      body: GradientBgImage(
        padding: EdgeInsets.zero,
        child: ListView(
            children: [
              SizedBox(height: 5,),
              SearchCategoryWidget(),
              SizedBox(height: 20,),
              SearchProductGridviewWidget(),
              SizedBox(height: 15,)
            ],
        ),
      ),
    );
  }
}
