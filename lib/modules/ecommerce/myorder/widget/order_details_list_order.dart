import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import '../model/order_details_model.dart';

class OrderDetailsListOrder extends StatelessWidget {
  List<Items>? items;
  OrderDetailsListOrder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: (items!.length <= 1)? 135 : (items!.length == 2)? 270: 400,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:const Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffC9CFD2).withOpacity(0.5),
            blurRadius: AppSizes.s5,
            spreadRadius: 1,
          )
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        reverse: false,
        physics: const ClampingScrollPhysics(),
        itemCount: items!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: (){
              },
              child: SizedBox(
                height: 104,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl:"${items![index].image![0].file}",
                      width: 90,
                      height: 99,
                      placeholder: (context, url) => const ShimmerAnimatedLoading(
                        circularRaduis: AppSizes.s50,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: AppSizes.s32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "${items![index].title}",
                            maxLines: 2,
                            style: const TextStyle(
                              color: Color(0xffE6007E),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                               Text(
                                 (items![index].priceAfterDiscount!=null)? "${items![index].priceAfterDiscount} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}":"${items![index].price} EGP",
                                style: const TextStyle(
                                  color: Color(0xff1B1B1B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${items![index].price}",
                                style: TextStyle(
                                  color: const Color(0xff1B1B1B).withOpacity(0.5),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                AppStrings.units.tr().toUpperCase(),
                                style:  const TextStyle(
                                  color: Color(AppColors.oc1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                               Text(
                                ": ${items![index].quantity}",
                                style: const TextStyle(
                                  color: Color(AppColors.oc1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
