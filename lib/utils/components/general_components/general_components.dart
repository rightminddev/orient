import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';

Widget defaultTapBarItem(
    {required List<String>? items,
    final Function? onTapItem,
    double? tapBarItemsWidth}) {
  var selectIndex = 0;
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      double itemWidth =
          (tapBarItemsWidth ?? MediaQuery.sizeOf(context).width * 0.9) /
              items!.length;
      return Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
            height: 45.0,
            width: tapBarItemsWidth ?? MediaQuery.sizeOf(context).width * 0.9,
            decoration: BoxDecoration(
                color: const Color(0xff0D3B6F),
                borderRadius: BorderRadius.circular(25)),
            child: ListView.builder(
              shrinkWrap: true,
              reverse: false,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectIndex = index;
                    });
                    if (onTapItem != null) {
                      onTapItem!(index);
                    }
                  },
                  child: Container(
                    height: 32,
                    width: itemWidth - 8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: (selectIndex == index)
                          ? const Color(0xffE6007E)
                          : Colors.transparent,
                    ),
                    child: Text(
                      items![index].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"),
                    ),
                  )),
              itemCount: items!.length,
            )),
      );
    },
  );
}

Widget defaultBottomNavigationBar(
    {required List<String>? items,
    final Function? onTapItem,
    double? tapBarItemsWidth}) {
  var selectIndex = 0;
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      double itemWidth =
          (tapBarItemsWidth ?? MediaQuery.sizeOf(context).width * 1) /
                  items!.length -
              6;
      return Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
            height: 81.0,
            width: tapBarItemsWidth ?? MediaQuery.sizeOf(context).width * 1,
            decoration: BoxDecoration(
                color: const Color(0xff0D3B6F),
                borderRadius: BorderRadius.circular(50)),
            child: ListView.builder(
              shrinkWrap: true,
              reverse: false,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectIndex = index;
                    });
                    if (onTapItem != null) {
                      onTapItem!(index);
                    }
                  },
                  child: Container(
                      width: itemWidth,
                      height: itemWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: (selectIndex == index)
                              ? const Color(0xffFFFFFF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(itemWidth)),
                      child: SvgPicture.asset(
                        items[index],
                        color: (selectIndex == index)
                            ? const Color(0xffE6007E)
                            : const Color(0xffFFFFFF),
                      ))),
              itemCount: items.length,
            )),
      );
    },
  );
}

Widget defaultProductContainer(
    {Color? containerColor,
    Color? bookmarkColor,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    required String? title,
    required String? price,
    required String? unit,
    String? discountPrice,
    required BuildContext? context,
    required bool? showBookMark,
    bool showUnit = true,
    required bool? showDiscountPrice,
    double? containerWidth,
    final void Function()? onPressedBookMark,
    required String? imageUrl}) {
  return Container(
    height: 104,
    width: containerWidth ?? MediaQuery.sizeOf(context!).width * 1,
    padding: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      color: containerColor ?? const Color(0xffFFFFFF),
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      boxShadow: boxShadow,
    ),
    child: Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
            height: 104.0,
            width: 100,
            placeholder: (context, url) => const ShimmerAnimatedLoading(
                  width: 100.0,
                  height: 104.0,
                  circularRaduis: 10,
                ),
            errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported_outlined,
                )),
      ),
      SizedBox(
        width: 16,
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context!).width * 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xffE6007E),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
              Row(
                children: [
                  Text(
                    price!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xff1B1B1B),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  if (showDiscountPrice == true)
                    Text(
                      discountPrice!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                        decorationThickness: 2,
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (showUnit == true)
                    Text(
                      unit!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color(0xff0D3B6F),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  const Spacer(),
                  if (showBookMark == true)
                    GestureDetector(
                        onTap: onPressedBookMark,
                        child: Icon(
                          Icons.bookmark,
                          color: bookmarkColor ?? const Color(0xffE6007E),
                        ))
                ],
              ),
            ],
          ),
        ),
      )
    ]),
  );
}
Widget defaultProfileContainer({
  required String? imageUrl,
  required String? userName,
  required String? userRole,
  required BuildContext? context,
}){
  return Container(
    color: Colors.black,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 63,  // Set your desired size
          height: 63,
          decoration:const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xffE6007E), Color(0xff224982)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(63),
              child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  height: 63,
                  width: 63,
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
        SizedBox(width: 10 ,),
        Container(
          width: MediaQuery.sizeOf(context!).width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 23,
                child: Text(
                  userName!.toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                ),
              ),
              const SizedBox(height: 1,),
              Container(
                height: 15,
                child: Text(
                  userRole!.toUpperCase(),
                  style: TextStyle(color: Color(0xffFFFFFF).withOpacity(0.5), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
