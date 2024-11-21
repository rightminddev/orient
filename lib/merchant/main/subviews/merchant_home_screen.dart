import 'package:flutter/material.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/notification/logic/notification_provider.dart';
import 'package:orient/modules/notification/view/notification_list_view_item.dart';
import 'package:orient/painter/home_screen/views/widgets/home_loading_page.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_images.dart';
import '../widgets/merchant_grid_view.dart';

class MerchantHomeScreen extends StatelessWidget {
  const MerchantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
        create: (context) =>
            NotificationProviderModel()..getNotification(context),
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Consumer<NotificationProviderModel>(
              builder: (context, notificationProviderModel, child) {
                return (notificationProviderModel.isGetNotificationLoading)
                    ? HomePainterLoadingPage()
                    : Scaffold(
                        backgroundColor: const Color(0xffFFFFFF),
                        body: GradientBgImage(
                          padding: EdgeInsets.zero,
                          child: CustomScrollView(
                            slivers: [
                              // SliverAppBar for the top section (Profile, Points Earned)
                              SliverAppBar(
                                expandedHeight: height * 0.4, //250,
                                pinned: true,
                                backgroundColor: Colors.transparent,
                                flexibleSpace: LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
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
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30)),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  AppImages.backgroundImage,
                                                ),
                                              )),
                                          child: value.userSettings != null
                                              ? Column(
                                                  children: [
                                                    gapH64,
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: defaultProfileContainer(
                                                              imageUrl:
                                                                  '${value.userSettings?.photo}',
                                                              userName:
                                                                  "${value.userSettings!.name}".split(" ")[0],
                                                              userRole: value
                                                                      .userSettings
                                                                      ?.role?[0] ??
                                                                  '',
                                                              context: context),
                                                        ),
                                                      ],
                                                    ),
                                                    gapH24,
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'HELLO ${value.userSettings!.name!.split(" ")[0]}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 36,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        const Text(
                                                          'Control your store',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 64,
                                                            fontFamily:
                                                                'NalikaSignature',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                              const MerchantGridView(),
                              // Sliver for notifications
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.s24),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            "Lasted notifications"
                                                .toUpperCase(),
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
                                      ListView.separated(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(
                                              bottom: AppSizes.s12),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                height: 18,
                                              ),
                                          itemCount: (notificationProviderModel
                                                      .notifications.length >
                                                  4)
                                              ? 4
                                              : notificationProviderModel
                                                  .notifications.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              PainterNotificationListViewItem(
                                                index: index,
                                                notifications:
                                                    notificationProviderModel
                                                        .notifications,
                                              )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            );
          },
        ));
  }
}
