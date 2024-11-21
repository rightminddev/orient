import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/general/viewmodels/company_structure_info.viewmodel.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/shared_more_screen/aboutus/logic/aboutus_logic.dart';
import 'package:orient/modules/shared_more_screen/aboutus/view/main_logo_and_title_widget.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List<String> taps = ["About", "history", "Certificates", "Partners"];
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AboutUsLogicProvider()..getAboutUs(context),
      child: Consumer<AboutUsLogicProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/png/about-us_background.png",
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
                      AppStrings.aboutApp.tr().toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      const MainLogoAndTitleWidget(),
                      const SizedBox(
                        height: 40,
                      ),
                      if (value.aboutUsModel != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: (selectIndex == 0)
                              ? SizedBox(
                            height: MediaQuery.sizeOf(context)
                                .height *
                                0.45,
                                child: SingleChildScrollView(
                                    child: Html(
                                        shrinkWrap: true,
                                        data: value.aboutUsModel!.page!.content,
                                        style: {
                                          "p": Style(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffFFFFFF),
                                            fontSize: FontSize(14),
                                          ),
                                        }),
                                  ),
                              )
                              : (selectIndex == 1)
                                  ? SizedBox(
                            height: MediaQuery.sizeOf(context)
                                .height *
                                0.45,
                                    child: SingleChildScrollView(
                                      child: Text(
                                          value.aboutUsModel!.page!.history!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffFFFFFF),
                                              fontSize: 14,
                                              height: 24 / 14),
                                        ),
                                    ),
                                  )
                                  : (selectIndex == 2)
                                      ? Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.45,
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  3, // 3 items per row
                                              mainAxisSpacing: 16.0,
                                              crossAxisSpacing: 16.0,
                                              childAspectRatio:
                                                  1, // Square aspect ratio
                                            ),
                                            itemCount: value.aboutUsModel!
                                                .page!.certificates!.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 8,
                                                      offset:
                                                          const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl: value
                                                              .aboutUsModel!
                                                              .page!
                                                              .certificates![
                                                                  index]
                                                              .file ??
                                                          "",
                                                      fit: BoxFit.fill,
                                                      placeholder: (context,
                                                              url) =>
                                                          const ShimmerAnimatedLoading(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                        Icons
                                                            .image_not_supported_outlined,
                                                        size: AppSizes.s32,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              );
                                            },
                                          ),
                                        )
                                      : (selectIndex == 3)
                                          ? Container(
                                              height:
                                                  MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.45,
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      3, // 3 items per row
                                                  mainAxisSpacing: 16.0,
                                                  crossAxisSpacing: 16.0,
                                                  childAspectRatio:
                                                      1, // Square aspect ratio
                                                ),
                                                itemCount: value.aboutUsModel!
                                                    .page!.partners!.length,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.1),
                                                          blurRadius: 8,
                                                          offset:
                                                              const Offset(
                                                                  0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: value
                                                                  .aboutUsModel!
                                                                  .page!
                                                                  .partners![
                                                                      index]
                                                                  .file ??
                                                              "",
                                                          fit: BoxFit.fill,
                                                          placeholder: (context,
                                                                  url) =>
                                                              const ShimmerAnimatedLoading(),
                                                          errorWidget:
                                                              (context, url,
                                                                      error) =>
                                                                  const Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                            size:
                                                                AppSizes.s32,
                                                            color:
                                                                Colors.white,
                                                          ),
                                                        )),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              height: 0,
                                            ),
                        )
                    ],
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultTapBarItem(
                      items: taps,
                      tapBarItemsWidth: MediaQuery.sizeOf(context).width * 0.95,
                      selectIndex: selectIndex,
                      onTapItem: (index) {
                        setState(() {
                          selectIndex = index;
                        });
                      },
                    ),
                  ),
                  extendBody: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
