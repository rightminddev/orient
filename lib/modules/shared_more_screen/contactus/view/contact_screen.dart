import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/common_modules_widgets/custom_elevated_button.widget.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/shared_more_screen/contactus/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int selectIndex = 0;
  var gCache;
  Future<void> openGoogleMaps({double? latitude, double? longitude}) async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactUsController(),
      child: Consumer<ContactUsController>(
        builder: (context, values, child) {
          final jsonString = CacheHelper.getString("USG");
          if (jsonString != null) {
            gCache = json.decode(jsonString)
                as Map<String, dynamic>; // Convert String back to JSON
            print("S2 IS --> $gCache");
          }
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/png/contact-us_background.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    leading: GestureDetector(
                      onTap: () {
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 50,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/svg/contact-phone.svg", height: 20, width: 20,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.phone.tr().toUpperCase(),
                                        style: TextStyle(
                                            color: const Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            final String phoneNumber =
                                                'tel:${gCache['company_contacts']['phone']}'; // Replace with the phone number you want to call
                                            if (await canLaunch(phoneNumber)) {
                                              await launch(phoneNumber);
                                            } else {
                                              throw 'Could not launch $phoneNumber';
                                            }
                                          },
                                          child: Text(
                                            "${AppStrings.hotline.tr().toUpperCase()} ${gCache['company_contacts']['phone']}",
                                            style: TextStyle(
                                                color: const Color(0xffFFFFFF),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            reverse: false,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                                    onTap: () async {
                                                      final String phoneNumber =
                                                          'tel:${gCache['company_contacts']['otherphones'][index]}'; // Replace with the phone number you want to call
                                                      if (await canLaunch(
                                                          phoneNumber)) {
                                                        await launch(
                                                            phoneNumber);
                                                      } else {
                                                        throw 'Could not launch $phoneNumber';
                                                      }
                                                    },
                                                    child: Text(
                                                      "${gCache['company_contacts']['otherphones'][index]}",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xffFFFFFF),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    )),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                      height: 5,
                                                    ),
                                            itemCount:
                                                gCache['company_contacts']
                                                        ['otherphones']
                                                    .length),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/svg/contact-address.svg", height: 20, width: 20,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.address.tr().toUpperCase(),
                                          style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      LocalizationService
                                                              .isArabic(
                                                                  context:
                                                                      context)
                                                          ? gCache['company_contacts']['branches']
                                                                  [index]
                                                              ['title']['ar']
                                                          : gCache['company_contacts']['branches'][index]['title']['en'],
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xffFFFFFF),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.6,
                                                        child: Text(
                                                          LocalizationService.isArabic(context: context)
                                                              ? "${gCache['company_contacts']['branches'][index]['co_info_address']['ar']}"
                                                              : "${gCache['company_contacts']['branches'][index]['co_info_address']['en']}",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14),
                                                        )),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await openGoogleMaps(
                                                          latitude: double.parse(
                                                              gCache['company_contacts']['branches'][index]['lat']),
                                                          longitude: double.parse(
                                                              gCache['company_contacts']['branches'][index]['lng']),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 17,
                                                        width: 78,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                    0xffFFFFFF)
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        child: Text(
                                                          AppStrings.showMap
                                                              .tr(),
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xffFFFFFF),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                      height: 10,
                                                    ),
                                            itemCount:
                                                gCache['company_contacts']
                                                        ['branches']
                                                    .length),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/svg/contact-email.svg", height: 20, width: 20,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.email.tr().toUpperCase(),
                                        style: const TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          values.sendMailToCompany(
                                              context: context,
                                              email: 'info@orient-paints.com',
                                              subject: null,
                                              body: null);
                                        },
                                        child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.6,
                                            child: Text(
                                              "info@orient-paints.com",
                                              style: const TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          values.sendMailToCompany(
                                              context: context,
                                              email: 'cs@orient-paints.com',
                                              subject: null,
                                              body: null);
                                        },
                                        child: SizedBox(
                                            width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.6,
                                            child: Text(
                                              "cs@orient-paints.com",
                                              style: const TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.followUs.tr().toUpperCase(),
                                      style: const TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 30,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          if (gCache['company_contacts']
                                                      ['whatsapp'] !=
                                                  null &&
                                              gCache['company_contacts']
                                                      ['whatsapp'] !=
                                                  "")
                                            defaultCircularSocial(
                                                src:
                                                    "assets/images/svg/whatsapp.svg",
                                                onTap: () async {
                                                  await launchUrl(
                                                      Uri.parse(gCache[
                                                              'company_contacts']
                                                          ['whatsapp']),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }),
                                          if (gCache['company_contacts']
                                                      ['linkedin'] !=
                                                  null &&
                                              gCache['company_contacts']
                                                      ['linkedin'] !=
                                                  "")
                                            defaultCircularSocial(
                                                src:
                                                    "assets/images/svg/linkedin.svg",
                                                onTap: () async {
                                                  await launchUrl(
                                                      Uri.parse(gCache[
                                                              'company_contacts']
                                                          ['linkedin']),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }),
                                          if (gCache['company_contacts']
                                                      ['youtube'] !=
                                                  null &&
                                              gCache['company_contacts']
                                                      ['youtube'] !=
                                                  "")
                                            defaultCircularSocial(
                                                src:
                                                    "assets/images/svg/youtube.svg",
                                                onTap: () async {
                                                  await launchUrl(
                                                      Uri.parse(gCache[
                                                              'company_contacts']
                                                          ['youtube']),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }),
                                          if (gCache['company_contacts']
                                                      ['instagram'] !=
                                                  null &&
                                              gCache['company_contacts']
                                                      ['instagram'] !=
                                                  "")
                                            defaultCircularSocial(
                                                src:
                                                    "assets/images/svg/instagram.svg",
                                                onTap: () async {
                                                  await launchUrl(
                                                      Uri.parse(gCache[
                                                              'company_contacts']
                                                          ['instagram']),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }),
                                          if (gCache['company_contacts']
                                                      ['facebook'] !=
                                                  null &&
                                              gCache['company_contacts']
                                                      ['facebook'] !=
                                                  "")
                                            defaultCircularSocial(
                                                src:
                                                    "assets/images/svg/facebook.svg",
                                                onTap: () async {
                                                  await launchUrl(
                                                      Uri.parse(gCache[
                                                              'company_contacts']
                                                          ['facebook']),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CustomElevatedButton(
                                      title: AppStrings.sendEmail.tr(),
                                      onPressed: () async {
                                        values.sendMailToCompany(
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

  Widget defaultCircularSocial({onTap, src}) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(5),
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xffE6007E)),
          child: SvgPicture.asset(src),
        ),
      );
}
