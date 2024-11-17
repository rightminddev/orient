import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/common_modules_widgets/custom_elevated_button.widget.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/general/viewmodels/company_structure_info.viewmodel.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/shared_more_screen/aboutus/logic/aboutus_logic.dart';
import 'package:orient/modules/shared_more_screen/aboutus/view/main_logo_and_title_widget.dart';
import 'package:orient/modules/shared_more_screen/contactus/controller/controller.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int selectIndex = 0;
  Future<void> openGoogleMaps({double? latitude, double? longitude}) async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps.';
    }
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ContactUsController()..getGeneral(context),
      child: Consumer<ContactUsController>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/png/contact-us_background.png",
                  fit: BoxFit.cover,
                ),
              ),
             if(!value.isLoading) Positioned.fill(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    leading: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      AppStrings.contactUs.tr().toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/images/svg/contact-phone.svg"),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(AppStrings.phone.tr().toUpperCase(), style: TextStyle(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 22), ),
                                        const SizedBox(height: 10,),
                                        Text("${AppStrings.hotline.tr().toUpperCase()} ${value.phone}", style: TextStyle(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w400, fontSize: 14), ),
                                        const SizedBox(height: 5,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              reverse: false,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) => Text("${value.hotPhone[index]}", style: TextStyle(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w400, fontSize: 14), ),
                                              separatorBuilder: (context, index) => SizedBox(height: 5,),
                                              itemCount: value.hotPhone.length
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/images/svg/contact-address.svg"),
                                    const SizedBox(width: 10,),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.6,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) => Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(AppStrings.address.tr().toUpperCase(), style: const TextStyle(color: Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 22), ),
                                              const SizedBox(height: 10,),
                                              Text(LocalizationService.isArabic(context: context)?value.branchs[index]['title']['ar']:value.branchs[index]['title']['en'], style: const TextStyle(color: Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 14), ),
                                              const SizedBox(height: 5,),
                                              SizedBox(
                                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                                  child: Text(LocalizationService.isArabic(context: context)?"${value.branchs[index]['co_info_address']['ar']}":"${value.branchs[index]['co_info_address']['en']}", style: TextStyle(color: const Color(0xffFFFFFF), fontWeight: FontWeight.w400, fontSize: 14), )),
                                              const SizedBox(height: 5,),
                                              GestureDetector(
                                                onTap: ()async{
                                                      await openGoogleMaps(
                                                        longitude: double.parse(value.branchs[index]['lat']),
                                                        latitude:double.parse(value.branchs[index]['lng']),
                                                      );
                                                },
                                                child: Container(
                                                  height: 17,
                                                  width: 78,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xffFFFFFF).withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  child: Text(AppStrings.showMap.tr(), style: TextStyle(color: const Color(0xffFFFFFF), fontSize: 10 ,fontWeight: FontWeight.w400),),
                                                ),
                                              )
                                            ],
                                          ),
                                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                                          itemCount: value.branchs.length
                                      ),
                                    )
                                  ],
                                ),
                              const SizedBox(height: 20,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/images/svg/contact-email.svg"),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(AppStrings.email.tr().toUpperCase(), style: const TextStyle(color: Color(0xffFFFFFF), fontWeight: FontWeight.w700, fontSize: 22), ),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context).width * 0.6,
                                            child: Text("info@orient-paints.com", style: const TextStyle(color: Color(0xffFFFFFF), fontWeight: FontWeight.w400, fontSize: 14), )),
                                        const SizedBox(height: 5,),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context).width * 0.6,
                                            child: Text("cs@orient-paints.com", style: const TextStyle(color: Color(0xffFFFFFF), fontWeight: FontWeight.w400, fontSize: 14), )),
                                      ],
                                    )
                                  ],
                                ),
                              const SizedBox(height: 50,),
                              Container(width: double.infinity,
                              alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(AppStrings.followUs.tr().toUpperCase(), style: const TextStyle(color: Color(0xffFFFFFF), fontWeight: FontWeight.w600, fontSize: 16), ),
                                    const SizedBox(height: 20,),
                                    Container(
                                      height: 30,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                         if(value.whatsApp != null &&value.whatsApp != "") defaultCircularSocial(
                                            src: "assets/images/svg/whatsapp.svg",
                                           onTap: ()async{
                                             await launchUrl(Uri.parse(value.whatsApp), mode: LaunchMode.externalApplication);
                                           }
                                          ),if(value.linkedIn != null &&value.linkedIn != "") defaultCircularSocial(
                                            src: "assets/images/svg/linkedin.svg",
                                              onTap: ()async{
                                                await launchUrl(Uri.parse(value.linkedIn), mode: LaunchMode.externalApplication);
                                              }
                                          ),if(value.youtube != null &&value.youtube != "") defaultCircularSocial(
                                            src: "assets/images/svg/youtube.svg",
                                              onTap: ()async{
                                                await launchUrl(Uri.parse(value.youtube), mode: LaunchMode.externalApplication);
                                              }
                                          ),if(value.instagram != null &&value.instagram != "") defaultCircularSocial(
                                            src: "assets/images/svg/instagram.svg",
                                              onTap: ()async{
                                                await launchUrl(Uri.parse(value.instagram), mode: LaunchMode.externalApplication);
                                              }
                                          ),if(value.facebook != null &&value.facebook != "") defaultCircularSocial(
                                            src: "assets/images/svg/facebook.svg",
                                              onTap: ()async{
                                                await launchUrl(Uri.parse(value.facebook), mode: LaunchMode.externalApplication);
                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    CustomElevatedButton(
                                      title: AppStrings.sendEmail.tr(),
                                      onPressed: ()async{
                                        value.sendMailToCompany(
                                            context: context,
                                            email: 'info@orient-paints.com',
                                            subject: null,
                                            body: null);
                                      },
                                      isPrimaryBackground: false,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget defaultCircularSocial({onTap, src})=>GestureDetector(
    onTap:onTap ,
    child:  Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(5),
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffE6007E)
      ),
      child: SvgPicture.asset(src),
    ),
  );
}
