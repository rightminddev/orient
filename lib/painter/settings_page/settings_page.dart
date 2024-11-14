import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/constants/settings/default_general_settings.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/models/settings/general_settings.model.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/painter/settings_page/setting_loading.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_shimmer_loading/shimmer_animated_loading.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        return SafeArea(
          child:  Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
            body: GradientBgImage(
              padding: EdgeInsets.zero,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.topCenter,
                        color: const Color(0xff0D3B6F).withOpacity(1),
                        height: MediaQuery.sizeOf(context).height * 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset("assets/images/png/sbacks.png",
                                width: double.infinity,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15,right: 15, bottom: MediaQuery.sizeOf(context).height * 0.15
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: (){},
                                        child: Icon(Icons.arrow_back, color: Color(0xffFFFFFF),)),
                                    Text(AppStrings.accountAndSettings.tr().toUpperCase(),
                                      style: const TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const Icon(Icons.arrow_back, color: Colors.transparent,),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2,),
                            Expanded(
                              child: ListView(
                                children: [
                                  defaultListTile(
                                      title: AppStrings.customizeNotifications.tr(),
                                      src: "assets/images/svg/s1.svg"
                                  ),
                                  defaultListTile(
                                      title: AppStrings.languageSettings.tr(),
                                      src: "assets/images/svg/s2.svg"
                                  ),defaultListTile(
                                      title: AppStrings.updatePassword.tr(),
                                      onTap: (){
                                        context.pushNamed(AppRoutes.updatePassword.name,
                                            pathParameters: {'lang': context.locale.languageCode,
                                            });
                                      },
                                      src: "assets/images/svg/s3.svg"
                                  ),defaultListTile(
                                      title: AppStrings.personalInfo.tr(),
                                      onTap: (){
                                        context.pushNamed(AppRoutes.personalInfoScreen.name,
                                            pathParameters: {'lang': context.locale.languageCode,
                                            });
                                      },
                                      src: "assets/images/svg/s4.svg"
                                  ),defaultListTile(
                                      title: AppStrings.aboutUs.tr(),
                                      onTap: (){
                                        context.pushNamed(AppRoutes.aboutusScreen.name,
                                            pathParameters: {'lang': context.locale.languageCode,
                                            });
                                      },
                                      src: "assets/images/svg/s5.svg"
                                  ),defaultListTile(
                                      title: AppStrings.contactUs.tr(),
                                      src: "assets/images/svg/s6.svg"
                                  ),defaultListTile(
                                      title: AppStrings.promoCode.tr(),
                                      onTap: (){
                                        context.pushNamed(AppRoutes.promoCodeScreen.name,
                                            pathParameters: {'lang': context.locale.languageCode,
                                            });
                                      },
                                      src: "assets/images/svg/promo.svg"
                                  ),defaultListTile(
                                      title: AppStrings.shippingAddress.tr(),
                                      onTap: (){
                                        context.pushNamed(AppRoutes.shippingAddress.name,
                                            pathParameters: {'lang': context.locale.languageCode,
                                            });
                                      },
                                      src: "assets/images/ecommerce/svg/checkout_location.svg"
                                  ),defaultListTile(
                                      title: AppStrings.logout.tr(),
                                       onTap: ()async{
                                            final appConfigService =
                                            Provider.of<AppConfigService>(context, listen: false);
                                            appConfigService.logout().then((v){
                                              context.goNamed(AppRoutes.splash.name,
                                                  pathParameters: {'lang': context.locale.languageCode});
                                            });
                                         },
                                      src: "assets/images/svg/s7.svg"
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.13,
                    child: Column(
                      children: [
                        Container(
                          width: 124,
                          height: 124,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFFFFFF)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(124),
                              child: CachedNetworkImage(
                                  imageUrl:(value.userSettings != null && value.userSettings2 != null )? value.userSettings!.photo! : "",
                                  fit: BoxFit.cover,
                                  height: 124,
                                  width: 124,
                                  placeholder: (context, url) => const ShimmerAnimatedLoading(
                                    width: 63.0,
                                    height: 63,
                                    circularRaduis: 63,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.image_not_supported_outlined,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          width: MediaQuery.sizeOf(context).width * 1,
                          child: Text((value.userSettings != null && value.userSettings2 != null )?"${value.userSettings!.name}".toUpperCase(): "NAME",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xffE6007E),
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                         Text(AppStrings.niceToMeetYou.tr(),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1B1B1B)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget defaultListTile({src, title, onTap})=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color(0xffC9CFD2).withOpacity(0.1),
            blurRadius: AppSizes.s5,
            spreadRadius: 1,
          )
        ],
      ),
      child: ListTile(
        leading: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xff9B9B9B).withOpacity(0.1)
            ),
            child: SizedBox(
              height: 17,
              width: 17,
              child: SvgPicture.asset(src, fit: BoxFit.scaleDown,),
            )),
        title: Text( "$title".toUpperCase(), style: TextStyle(
            color:  const Color(0xff1B1B1B).withOpacity(0.7), fontWeight: FontWeight.w500, fontSize: 12
        ),),
        trailing: SvgPicture.asset("assets/images/svg/sarrow.svg"),
        onTap: onTap ?? (){}, // Add your onTap functionality here
      ),
    ),
  );
}
