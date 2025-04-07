import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/notification/logic/notification_provider.dart';
import 'package:orient/modules/notification/view/notification_list_view_item.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:orient/utils/custom_shimmer_loading/shimmer_animated_loading.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PrizeScreen extends StatefulWidget {
  final bool viewArrow;
  PrizeScreen(this.viewArrow);

  @override
  _PrizeScreenState createState() => _PrizeScreenState();
}

class _PrizeScreenState extends State<PrizeScreen> {
  final ScrollController _scrollController = ScrollController();
  late PointsProvider pointsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pointsProvider = Provider.of<PointsProvider>(context, listen: false);
      pointsProvider.getPrize(context, page: 1);
    });
    _scrollController.addListener(() {
      print("Current scroll position: ${_scrollController.position.pixels}");
      print("Max scroll extent: ${_scrollController.position.maxScrollExtent}");

      if ((_scrollController.position.maxScrollExtent - _scrollController.position.pixels).abs() < 10 &&
          !pointsProvider.isLoading &&
          pointsProvider.hasMorePrizes) {
        print("BOTTOM BOTTOM");
        pointsProvider.getPrize(context, page: pointsProvider.currentPage);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        return Consumer<PointsProvider>(
          builder: (context, points, child) {
            if(points.isRedeemSuccess == true){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                points.getPrize(context, page: 1);
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                value.initializeHomeScreen(context);
              });
              points.isRedeemSuccess = false;
            }
            return SafeArea(
              child: Scaffold(
                backgroundColor: const Color(0xffFFFFFF),
                body: SingleChildScrollView(
                  controller: _scrollController,
                  child: GradientBgImage(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 90,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back, color: widget.viewArrow ? const Color(0xff224982) : Colors.transparent),
                                onPressed: () => widget.viewArrow ? Navigator.pop(context) : null,
                              ),
                              Text(
                                AppStrings.chooseThePrize.tr().toUpperCase(),
                                style: const TextStyle(color: Color(0xff224982), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.transparent),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.s20),
                        if(points.prizes.isEmpty)Container(
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          alignment: Alignment.center,
                          child: Text(AppStrings.noPrizesAvailable.tr(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight:  FontWeight.w700,
                                color: Color(0xff0D3B6F)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            reverse: false,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const SizedBox(height: 10,),
                            itemCount: points.isLoading
                                ? 12 // Show 5 loading items initially
                                : points.prizes.length,
                            itemBuilder: (context, index) {
                              if (points.isLoading && points.currentPage == 1) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: AppSizes.s12),
                                    padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSizes.s15, vertical: AppSizes.s12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(AppSizes.s15),
                                    ),
                                    height: 100,
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      points.selectIndex = index;
                                      print("selectIndex = ${points.selectIndex}");
                                    });
                                    points.postRedeemPrize(context, id: points.prizes[index]['id']);
                                  },
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.symmetric(
                                        horizontal: AppSizes.s15, vertical: AppSizes.s12),
                                    decoration: BoxDecoration(
                                      color: const Color(AppColors.textC5),
                                      borderRadius: BorderRadius.circular(AppSizes.s15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.05),
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            blurRadius: 10)
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                              imageUrl: (points.prizes[index]['image'].isNotEmpty)?
                                              points.prizes[index]['image'][0]['file'] : "",
                                              fit: BoxFit.fill,
                                              height: 110,
                                              width: double.infinity,
                                              placeholder: (context, url) => const ShimmerAnimatedLoading(
                                                width: 63.0,
                                                height: 63,
                                                circularRaduis: 63,
                                              ),
                                              errorWidget: (context, url, error) => const Icon(
                                                Icons.image_not_supported_outlined,
                                              )),
                                        ),
                                        gapH14,
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if(!points.isRedeemLoading) Icon(Icons.arrow_back_ios, size: 16,),
                                            if(!points.isRedeemLoading)  gapH4,
                                            if(!points.isRedeemLoading)  Text("${points.prizes[index]['points']} ${AppStrings.points.tr()}".toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:  FontWeight.w700,
                                                  color: Color(0xff0D3B6F)),
                                            ),
                                            if(points.isRedeemLoading && points.selectIndex == index)const CircularProgressIndicator()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        if (points.isLoading && points.currentPage != 1)
                          const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
