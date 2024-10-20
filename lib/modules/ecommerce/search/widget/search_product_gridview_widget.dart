import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/utils/components/general_components/general_components.dart';

class SearchProductGridviewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        reverse: false,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: .7,
        ),
        itemBuilder: (context, index)=>  defaultViewProductGrid(
            productName: "PUTTY (ACRYLIC 1000) 233",
            productType: "wall Paints",
            productPrice: "230.0 EGP",
            discountPrice: "250.0 EGP",
            productImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeogNQYdaKCFhphC-7rVur2DfMVgMqq9Yg-A&s",
            boxShadow: [
              BoxShadow(
                color: const Color(0xffC9CFD2).withOpacity(0.5),
                blurRadius: AppSizes.s8,
                spreadRadius: 1,
              )
            ],
          onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> EcommerceSingleProductDetailScreen()));
          }
        ),
        itemCount: 20,
      ),
    );
  }
}
