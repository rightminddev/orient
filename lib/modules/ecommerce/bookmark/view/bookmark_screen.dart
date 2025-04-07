import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/localization.service.dart';
import 'package:orient/modules/ecommerce/bookmark/controller/bookmark_controller.dart';
import 'package:orient/modules/ecommerce/bookmark/view/bookmark_loading_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final ScrollController _scrollController = ScrollController();

  late BookmarkControllerProvider bookmarkControllerProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookmarkControllerProvider = Provider.of<BookmarkControllerProvider>(context, listen: false);
      bookmarkControllerProvider.getBookMark(context, page: 1);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !bookmarkControllerProvider.isLoading &&
          bookmarkControllerProvider.hasMoreBookmarks) {
        bookmarkControllerProvider.getBookMark(context, page: bookmarkControllerProvider.currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkControllerProvider>(
      builder: (context, value, child) {
        if(value.isSuccessAdd == true){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            bookmarkControllerProvider.currentPage = 1;
            bookmarkControllerProvider.getBookMark(context, page: 1);
          });
          value.isSuccessAdd = false;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffFFFFFF),
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
            title: Text(
              AppStrings.bookMark.tr().toUpperCase(),
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
          backgroundColor: Color(0xffFFFFFF),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: GradientBgImage(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        reverse: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) =>(value.isLoading && value.currentPage == 1)?
                        const BookmarkLoadingScreen()
                            :GestureDetector(
                          onTap: (){
                            context.pushNamed(AppRoutes.ecommerceSingleProductDetailScreen.name,
                                pathParameters: {'lang': context.locale.languageCode,
                                  'viewPrice' : 'true',
                                  'id' : "${value.bookmarks[index]['id']}"});
                          },
                              child: defaultProductContainer(
                              title: value.bookmarks[index]['title'],
                              showUnit: false,
                              onPressedBookMark: (){
                                value.addOrRemoveBookMark(context, id: value.bookmarks[index]['id']);
                              },
                              price: "${value.bookmarks[index]['regular_price']} ${LocalizationService.isArabic(context: context)? "جنيه" : "ُEGP"}",
                              context: context,
                              showBookMark: (value.isLoadingAdd)? false: true,
                              showDiscountPrice: true,
                              discountPrice: "${value.bookmarks[index]['price']} EGP",
                              imageUrl: (value.bookmarks[index]['main_cover'].isNotEmpty)?value.bookmarks[index]['main_cover'][0]["file"] : ''
                                                      ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(height: 16,),
                        itemCount: (value.isLoading && value.bookmarks.isEmpty)?5 :value.bookmarks.length
                    ),
                    if (value.isLoading && value.currentPage != 1) const SizedBox(height: 10,),
                    if (value.isLoading&& value.currentPage != 1)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),

              ),
            ),
          ),
        );
      },
    );
  }
}
