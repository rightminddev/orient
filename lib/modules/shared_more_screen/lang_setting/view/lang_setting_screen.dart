import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/general_services/settings.service.dart';
import 'package:orient/models/settings/general_settings.model.dart';
import 'package:orient/modules/shared_more_screen/lang_setting/logic/lang_controller.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class LangSettingScreen extends StatefulWidget {
  @override
  State<LangSettingScreen> createState() => _LangSettingScreenState();
}

class _LangSettingScreenState extends State<LangSettingScreen> {
  int? selectIndex;
  String? selectValue;
  @override
  Widget build(BuildContext context) {
    List<String>? lang = (AppSettingsService.getSettings(
        context: context,
        settingsType: SettingsType.generalSettings) as GeneralSettingsModel)
        .availableLang;
    lang = (lang == null || lang.isEmpty)
        ? ["English language",
      "اللغه العربية"]
        : lang;
    print("is--->${context.locale.languageCode}");
    if(context.locale.languageCode != null){
      if(context.locale.languageCode.contains("en")){
        selectIndex = 0;
      }if(context.locale.languageCode.contains("ar")){
        selectIndex = 1;
      }
    }
    print("LANG Is : $lang");
    return ChangeNotifierProvider(create: (context) => LangControllerProvider(),
    child: Consumer<LangControllerProvider>(builder: (context, value, child) {
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
            AppStrings.languageSettings.tr().toUpperCase(),
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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 1,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: ()async{
                                setState(() {
                                  selectIndex = index;
                                  selectValue = lang![index].toString();
                                });
                               await value.setDeviceSysLang(
                                    state: (selectValue == "اللغه العربية")? "ar" : "en",
                                  context: context,
                                  notiToken:await FirebaseMessaging.instance.getToken()
                                );
                                LocalizationService.setLocaleAndUpdateUrl(
                                    context: context, newLangCode: (selectValue == "اللغه العربية")? "ar" : "en");
                                print("selectValue is ----> $selectValue");
                                CacheHelper.setString(key: "lang", value: (selectValue == "اللغه العربية")? "ar" : "en");
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffC9CFD2).withOpacity(0.5),
                                        blurRadius: AppSizes.s5,
                                        spreadRadius: 1,
                                      )
                                    ]
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xffE6007E)),
                                          color:(selectIndex == index)? const Color(0xffE6007E) : const Color(0xffFFFFFF)
                                      ),
                                      child: const Icon(Icons.check, color: Colors.white, size: 18,),
                                    ),
                                    const SizedBox(width: 15,),
                                    Text((lang![index].contains("English language")||lang![index].contains("en"))?"English language".toUpperCase() : "اللغه العربية", style: const TextStyle(color: Color(0xff191C1F), fontWeight: FontWeight.w500, fontSize: 14),)
                                    ,const Spacer(),
                                    GestureDetector(
                                        onTap: (){},
                                        child: Text((lang![index].contains("en"))?"change".toUpperCase() : "تغيير", style: const TextStyle(fontSize: 12 ,fontWeight: FontWeight.w500, color: Color(0xffE6007E)),))
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(height: 19,),
                            padding: EdgeInsets.zero,
                            itemCount: lang!.length
                        ),
                        const SizedBox(height: 40,),
                        // SizedBox(
                        //   width: MediaQuery.sizeOf(context).width * 0.6,
                        //   child: GestureDetector(
                        //     onTap: (){
                        //       //  Navigator.pop(context);
                        //     },
                        //     child: Container(
                        //       height: 50,
                        //       alignment: Alignment.center,
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xff0D3B6F),
                        //         borderRadius: BorderRadius.circular(50),
                        //       ),
                        //       padding: const EdgeInsets.symmetric(horizontal: 40),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           SvgPicture.asset("assets/images/svg/add-lang.svg"),
                        //           const SizedBox(width: 12,),
                        //           Text(
                        //             AppStrings.addLanguage.tr().toUpperCase(),
                        //             style:const TextStyle(
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Color(0xffFFFFFF)
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                )
            ),
          ),
        ),
      );
    },),
    );
  }
}
