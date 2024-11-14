import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/shared_more_screen/promocode/controller/promocode_controller.dart';
import 'package:provider/provider.dart';

class PromoCodeScreen extends StatelessWidget {
  const PromoCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PromoCodeControllerModel()..getPromos(context: context),
      child: Consumer<PromoCodeControllerModel>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: const Color(0xff0D3B6F),
            appBar:AppBar(
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                  child: const Icon(Icons.arrow_back, color: Color(0XFFFFFFFF),)),
              title: Text(
                AppStrings.promoCode.tr().toUpperCase(),
                style: const TextStyle(
                    fontSize: AppSizes.s16,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFFFFFFFF)),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 1,
                    child:(!value.isLoading)? ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/images/png/coupon_container.png"),
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.5,
                                      child:  Text(value.codes[index]['title'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(AppColors.oc2)),)),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.5,
                                      child:  Text(value.codes[index]['code'],maxLines: 1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff1B1B1B)),)),
                                  const SizedBox(height: 5,),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.5,
                                      child: Text(value.codes[index]['description'], style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: const Color(0xff000000).withOpacity(0.3)),)),
                                ],
                              ),
                            )
                          ],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(height: 20,),
                        itemCount: value.codes.length
                    ) : Container(height: 0.0,),
                  ),
                  const SizedBox(height: 10,),
                  Image.asset("assets/images/png/coupons.png")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
