import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/home/controller/const.dart';
import 'package:orient/modules/ecommerce/home/controller/home_controller.dart';
import 'package:orient/modules/ecommerce/search/controller/search_controller.dart';
import 'package:orient/modules/ecommerce/search/search_screen_loading.dart';
import 'package:orient/modules/ecommerce/search/widget/search_category_widget.dart';
import 'package:orient/modules/ecommerce/search/widget/search_filter_widget.dart';
import 'package:orient/modules/ecommerce/search/widget/search_product_gridview_widget.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class ECommerceSearchScreen extends StatefulWidget {
  var categoryId;
  ECommerceSearchScreen({this.categoryId});
  @override
  State<ECommerceSearchScreen> createState() => _ECommerceSearchScreenState();
}

class _ECommerceSearchScreenState extends State<ECommerceSearchScreen> {
  late SearchControllerProvider searchControllerProvider;
  late HomeProvider homeProvider;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    print("ID-------------------> ${widget.categoryId}");
    searchControllerProvider = SearchControllerProvider();
    homeProvider = HomeProvider();
    searchControllerProvider.getSearch(context: context, category_id: widget.categoryId, isNewPage: false);
    homeProvider.getPages(context: context, fromHome: false);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        searchControllerProvider.getSearch(
            context: context, category_id: widget.categoryId,isNewPage: true);
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: searchControllerProvider),
        ChangeNotifierProvider.value(value: searchControllerProvider),
        ChangeNotifierProvider.value(value: homeProvider)
      ],
      child: Consumer<SearchControllerProvider>(
        builder: (context, searchControllerProvider, child) {
          return Consumer<HomeProvider>(
            builder: (context, value, child) {
              return Scaffold(
                backgroundColor: const Color(0xffFFFFFF),
                body: (searchControllerProvider.isLoadingSearch &&
                       value.isLoading )
                    ? const GradientBgImage(
                    padding: EdgeInsets.zero,
                    child: SearchScreenLoading())
                    : SizedBox(
                        height: MediaQuery.sizeOf(context).height * 1,
                        child: GradientBgImage(
                          padding: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                Container(
                                  padding:const EdgeInsets.symmetric(horizontal: 15),
                                  color: Colors.transparent,
                                  height: 90,
                                  width: double.infinity,
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back,
                                            color: Color(0xff224982)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text(
                                        AppStrings.shop.tr().toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff224982)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            35.0)),
                                              ),
                                              builder: (BuildContext context) {
                                                return SearchFilterWidget(
                                                  contexts: context,
                                                );
                                              },
                                            );
                                            print(
                                                "MIN----->${SearchConstant.minPriceController.text}");
                                            searchControllerProvider.getSearch(
                                              context: context,
                                              crossSells: true,
                                              colorId: SearchConstant.selectColorId ,
                                              sizeId: SearchConstant.selectSizeId,
                                              attributesSizeId: SearchConstant.selectSizeAttributesId,
                                              attributesColorId: SearchConstant.selectColorAttributesId,
                                            );
                                          },
                                          child: Container(
                                              width: 32,
                                              height: 32,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE6007E),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: SvgPicture.asset(
                                                  "assets/images/ecommerce/svg/fliter.svg")),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SearchCategoryWidget(),
                                const SizedBox(
                                  height: 20,
                                ),
                                SearchProductGridviewWidget(),
                                const SizedBox(
                                  height: 15,
                                ),
                               if(searchControllerProvider.isLoadingSearch &&
                                   searchControllerProvider.pageNumber != 1
                               ) const CircularProgressIndicator()
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
