import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';
Widget defaultTap2BarItem(
    {required List<String>? items,
      final Function? onTapItem,
      double? tapBarItemsWidth}) {
  //var selectIndex = 0;
  return Consumer<PointsProvider>(
    builder: (context, provider, child) {
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
                    provider.changeIndex(index);

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
                      color: (provider.selectedIndex == index)
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
  Widget defaultTapBarItem(
      {required List<String>? items,
      final Function? onTapItem,
        int? selectIndex,
      double? tapBarItemsWidth}) {

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        double itemWidth =
            (tapBarItemsWidth ?? MediaQuery.sizeOf(context).width * 0.95) /
                items!.length;
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7.5),
            height: 45.0,
            width: tapBarItemsWidth ?? MediaQuery.sizeOf(context).width * 0.95,
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
                      if (onTapItem != null) {
                        onTapItem!(index);
                      }
                    });
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
                          fontSize: 11,
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins"),
                    ),
                  )),
              itemCount: items!.length,
            ));
      },
    );
  }
Widget defaultBottomNavigationBar(
    {required List<String>? items,
      final Function? onTapItem,
      double? tapBarItemsWidth,
      int? selectIndex = 0,
    }) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      double containerWidth = tapBarItemsWidth ?? MediaQuery.sizeOf(context).width;
      double itemWidth = containerWidth / items!.length * 0.9;
      double itemHeight = itemWidth * 1;
      double itemRadius = itemWidth / 2;
      print("SELECTED => ${selectIndex}");
      return Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
            height: itemHeight + 15,
            width: containerWidth,
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
                      if (onTapItem != null) {
                        onTapItem!(index);
                      }
                    });
                  },
                  child: Container(
                      width: itemWidth,
                      height: itemHeight,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: (selectIndex == index)
                              ? const Color(0xffFFFFFF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(itemRadius)),
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
// Widget defaultBottomNavigationBar(
//     {required List<String>? items,
//       void Function(int? index)? onTap,
//     double? tapBarItemsWidth,
//     int? selectIndex,
//       BuildContext? context
//     }) {
//   double containerWidth = tapBarItemsWidth ?? MediaQuery.sizeOf(context!).width;
//   double itemWidth = containerWidth / items!.length * 0.9;
//   double itemHeight = itemWidth * 1;
//   double itemRadius = itemWidth / 2;
//   int? selectIndex;
//   return StatefulBuilder(
//       builder: (context),
//   )
// }

Widget defaultProductContainer(
    {Color? containerColor,
    Color? bookmarkColor,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    required String? title,
    required String? price,
     String? unit,
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
}) {
  return Container(
    color: Colors.transparent,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 63,
          height: 63,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xffE6007E), Color(0xff224982)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(63),
              child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
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
        SizedBox(
          width: 10,
        ),
        Container(
          width: MediaQuery.sizeOf(context!).width * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 23,
                child: Text(
                  userName!.toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                height: 15,
                child: Text(
                  userRole!.toUpperCase(),
                  style: TextStyle(
                      color: Color(0xffFFFFFF).withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget defaultViewProductGrid(
    {List<BoxShadow>? boxShadow,
      required String? productType,
      required String? productName,
      required String? productPrice,
      required String? productImageUrl,
      required void Function()? onTap,
      String? discountPrice,
      bool? showDiscount,
      bool? showSale,
      double? containerWidth,
      double? containerHeight,
    }) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: containerWidth ?? 150,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: containerHeight ?? 218,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                    imageUrl: productImageUrl!,
                    fit: BoxFit.cover,
                    height: 155,
                    width: containerWidth ?? 170,
                    placeholder: (context, url) =>  ShimmerAnimatedLoading(
                      width: containerWidth ?? 170,
                      height: 155,
                      circularRaduis: 10,
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_outlined,
                    )),
              ),
             if(showSale == true) Padding(
                padding: const EdgeInsets.only(top: 7, left: 22),
                child: SvgPicture.asset(
                  'assets/images/svg/sale.svg',
                ),
              )
            ],
          ),
          Text(
            productType!,
            style: const TextStyle(
              color: Color(0xffE6007E),
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: 20,
            child: Text(
              productName!,
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xff0D3B6F),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: "$productPrice ",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Color(0xff0D3B6F),
                  fontFamily: "Poppins"),
              children: <TextSpan>[
                if(showDiscount == true)  TextSpan(
                  text: discountPrice!,
                  style: const TextStyle(
                    color: Color(0xffE6007E),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Color(0xffE6007E),
                    decorationThickness: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget defaultMinImageAppbar({
  double? containerHeight
}){
  return Container(
    height: containerHeight ?? 298,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30))),
    width: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30)),
              child: Image.asset(
                "assets/images/png/back_ground_fill.png",
                fit: BoxFit.fill,
              )),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30)),
          child: Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    const Color(0xFF0D3B6F).withOpacity(0.8),
                    const Color(0xFF0D3B6F).withOpacity(0.8),
                  ],
                  stops:const [1.0, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
Widget defaultFillImageAppbar({
  double? containerHeight
}){
  return Container(
    height: containerHeight ?? 212,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30))),
    width: double.infinity,
    child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30)),
        child: Image.asset(
          "assets/images/png/point_background.png",
          fit: BoxFit.cover,
        )),
  );
}
