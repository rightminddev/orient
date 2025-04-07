// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:orient/constants/app_sizes.dart';
// import 'package:orient/constants/app_strings.dart';
// import 'package:orient/general_services/localization.service.dart';
// import 'package:orient/modules/ecommerce/single_product/single_product_screen.dart';
// import 'package:orient/utils/components/general_components/general_components.dart';
//
// class HomeBestOfferProduct extends StatelessWidget {
//   const HomeBestOfferProduct({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           Container(
//             height: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(AppStrings.bestOffers.tr().toUpperCase(),
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                     color: Color(0xff1B1B1B),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(AppStrings.seeMore.tr().toUpperCase(),
//                       style:const TextStyle(
//                           color: Color(0xff1B1B1B),
//                           fontSize: 8,
//                           fontWeight: FontWeight.w400
//                       ),
//                     ),
//                     const SizedBox(width: 10,),
//                     const Icon(Icons.arrow_forward, color: Color(0xff1B1B1B),size: 14,)
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Container(
//               height: 240,
//               padding:const EdgeInsets.symmetric(vertical: 10,),
//               child: Row(
//                 children: [
//                   defaultViewProductGrid(
//                     productId: ,
//                       productName: "PUTTY (ACRYLIC 1000) 233",
//                       productType: "wall Paints",
//                       productPrice: "230.0 ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
//                       discountPrice: "250.0 ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
//                       productImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeogNQYdaKCFhphC-7rVur2DfMVgMqq9Yg-A&s",
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xffC9CFD2).withOpacity(0.5),
//                           blurRadius: AppSizes.s8,
//                           spreadRadius: 1,
//                         )
//                       ],
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=> EcommerceSingleProductDetailScreen(1)));
//                       }
//                   ),
//                   SizedBox(width: 10,),
//                   defaultViewProductGrid(
//                       productName: "PUTTY (ACRYLIC 1000) 233",
//                       productType: "wall Paints",
//                       productPrice: "230.0 ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
//                       discountPrice: "250.0 ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
//                       productImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQooC-itc8AKLusFN4GN6nP6Ou-IslCuUFVmA&s",
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xffC9CFD2).withOpacity(0.5),
//                           blurRadius: AppSizes.s8,
//                           spreadRadius: 1,
//                         )
//                       ],
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=> EcommerceSingleProductDetailScreen(1)));
//                       }
//                   ),
//                 ],
//               )
//           )
//         ],
//       ),
//     );
//   }
// }
