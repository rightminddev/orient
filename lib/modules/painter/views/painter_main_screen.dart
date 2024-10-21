import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/list/views/list_screen.dart';
import 'package:orient/modules/painter/views/widgets/painter_gride_view.dart';
import 'package:orient/modules/painter/views/widgets/painter_notification_list_view.dart';

class PainterMainScreen extends StatelessWidget {
  const PainterMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
              expandedHeight: height * 0.30, //250,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
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
                                AppImages.backgroundImage,
                              ),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gapH64,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ListScreen();
                                          },
                                        ));
                                      },
                                      child: CircleAvatar(
                                        radius: AppSizes.s32,
                                        child: Image.asset(
                                          AppImages.user,
                                        ),
                                      ),
                                    ),
                                    gapW10,
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "AHMED MOHAMED",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(AppColors.textC5)),
                                        ),
                                        Text(
                                          "MAS GROUP",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(AppColors.textC5)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  AppImages.notification,
                                  width: AppSizes.s30,
                                  height: AppSizes.s30,
                                )
                              ],
                            ),
                            gapH24,
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "MY POINTS EARNED",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(AppColors.textC5)),
                                    ),
                                    gapW4,
                                    SvgPicture.asset(
                                      AppImages.questionMark,
                                      width: AppSizes.s26,
                                      height: AppSizes.s26,
                                    )
                                  ],
                                ),
                                gapH8,
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.logoWhite,
                                      width: AppSizes.s46,
                                      height: AppSizes.s44,
                                    ),
                                    gapW10,
                                    const Text(
                                      "54,271",
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w500,
                                          color: Color(AppColors.textC5)),
                                    ),
                                    gapW10,
                                    const Text(
                                      "POINTS",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(AppColors.textC5)),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -26,
                      child: Opacity(
                        opacity: top <= 120.0 ? 0.0 : 1.0,
                        child: Container(
                          width: width * 0.75,
                          height: AppSizes.s53,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.s24, vertical: AppSizes.s10),
                          decoration: BoxDecoration(
                            color: const Color(AppColors.textC5),
                            borderRadius: BorderRadius.circular(AppSizes.s10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "1294-1256-5523-5520",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff191C1F)),
                              ),
                              SvgPicture.asset(AppImages.sendNow)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
            PainterGrideView(),
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
                    const PainterNotificationListView()
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
