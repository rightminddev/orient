import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/painters/merchants/views/widgets/merchant_gride_view.dart';
import 'package:orient/modules/painters/merchants/views/widgets/merchant_notification_list_view.dart';

class MerchantsHomeScreen extends StatelessWidget {
  const MerchantsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                radius: 0.8,
                stops: [0.1, 1.0],
                center: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(255, 0, 123, 0.10),
                  Color.fromRGBO(0, 161, 255, 0.10)
                ])),
        child: CustomScrollView(
          slivers: [
            // SliverAppBar for the top section (Profile, Points Earned)
            SliverAppBar(
              expandedHeight: height * 0.305, //250,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    FlexibleSpaceBar(
                      background: Container(
                        padding: const EdgeInsets.only(
                          right: AppSizes.s24,
                          left: AppSizes.s24,
                        ),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                AppImages.merchentBackGround,
                              ),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            gapH64,
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: AppSizes.s25,
                                    child: Image.asset(
                                      AppImages.user,
                                    ),
                                  ),
                                  gapW10,
                                  const Text(
                                    "AHMED MOHAMED",
                                    style: TextStyle(
                                        fontSize: AppSizes.s16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppColors.textC5)),
                                  )
                                ],
                              ),
                            ),
                            gapH32,
                            Text(
                              "Hello Ahmed".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: AppSizes.s30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(AppColors.textC5)),
                            ),
                            SvgPicture.asset(AppImages.controlYourStore,height:AppSizes.s64,width:MediaQuery.of(context).size.width*0.209)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const MerchantGrideView(),
            // Sliver for notifications
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH32,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xffE0E0E0),
                          ),
                        ),
                        gapW8,
                        Text(
                          "Lasted notifications".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffEE3F80)),
                        ),
                        gapW8,
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xffE0E0E0),
                          ),
                        ),
                      ],
                    ),
                    gapH8,
                    const MerchantNotificationListView()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
