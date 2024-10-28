import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
import 'package:orient/utils/components/general_components/general_components.dart';

class HomeMetalPointsProduct extends StatelessWidget {
  const HomeMetalPointsProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Metal Paints".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xff1B1B1B),
                  ),
                ),
                Row(
                  children: [
                    Text("see more".toUpperCase(),
                      style:const TextStyle(
                          color: Color(0xff1B1B1B),
                          fontSize: 8,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Icon(Icons.arrow_forward, color: Color(0xff1B1B1B),size: 14,)
                  ],
                )
              ],
            ),
          ),
          Container(
              height: 240,
              padding:const EdgeInsets.symmetric(vertical: 10,),
              child: Row(
                children: [
                  defaultViewProductGrid(
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
                  const SizedBox(width: 10,),
                  defaultViewProductGrid(
                      productName: "PUTTY (ACRYLIC 1000) 233",
                      productType: "wall Paints",
                      productPrice: "230.0 EGP",
                      discountPrice: "250.0 EGP",
                      productImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQooC-itc8AKLusFN4GN6nP6Ou-IslCuUFVmA&s",
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
                ],
              )
          )
        ],
      ),
    );
  }
}
