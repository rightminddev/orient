import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (context, index) => defaultProductContainer(
                    title: "PUTTY (ACRYLIC 1000) 233",
                    showUnit: false,
                    price: "250.0 EGP",
                    context: context,
                    showBookMark: true,
                    showDiscountPrice: true,
                    discountPrice: "300.5 EGP",
                    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQooC-itc8AKLusFN4GN6nP6Ou-IslCuUFVmA&s"
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 16,),
                itemCount: 10
            ),
          ),
        ),
      ),
    );
  }
}
