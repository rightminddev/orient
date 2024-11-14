import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/ecommerce/bookmark/controller/bookmark_controller.dart';
import 'package:orient/modules/ecommerce/bookmark/view/bookmark_loading_screen.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => BookmarkControllerProvider()..getBookMark(context),
    child: Consumer<BookmarkControllerProvider>(
      builder: (context, value, child) {
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
          body: GradientBgImage(
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: ListView.separated(
                    shrinkWrap: true,
                    reverse: false,
                    itemBuilder: (context, index) =>(value.isLoading)?
                    const BookmarkLoadingScreen()
                        :defaultProductContainer(
                        title: value.bookmarks[index]['title'],
                        showUnit: false,
                        onPressedBookMark: (){
                          value.addOrRemoveBookMark(context, id: value.bookmarks[index]['id']);
                        },
                        price: "${value.bookmarks[index]['regular_price']} EGP",
                        context: context,
                        showBookMark: (value.isLoadingAdd)? false: true,
                        showDiscountPrice: true,
                        discountPrice: "${value.bookmarks[index]['price']} EGP",
                        imageUrl: (value.bookmarks[index]['main_cover'].isNotEmpty)?value.bookmarks[index]['main_cover'][0]["file"] : ''
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 16,),
                    itemCount: (value.isLoading)?5 :value.bookmarks.length
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
