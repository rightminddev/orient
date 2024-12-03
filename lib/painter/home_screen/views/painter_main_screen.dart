  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/notification/logic/notification_provider.dart';
import 'package:orient/modules/notification/view/notification_list_view_item.dart';
import 'package:orient/painter/home_screen/views/home_model.dart';
import 'package:orient/painter/home_screen/views/widgets/home_loading_page.dart';
import 'package:orient/painter/home_screen/views/widgets/painter_gride_view.dart';
import 'package:orient/painter/home_screen/views/widgets/upload_code_home_widget.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
 TextEditingController codeController = TextEditingController();
 var totalPoints;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => NotificationProviderModel()..getNotification(context),),
      ChangeNotifierProvider(create: (context) => HomeModelProvider(),),
      ChangeNotifierProvider(create: (context) => HomeViewModel()..initializeHomeScreen(context),),
    ],
    child: Consumer<HomeModelProvider>(
      builder: (context, homeModelProvider, child) {
        return Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Consumer<NotificationProviderModel>(builder:
            (context, notificationProviderModel, child) {
              if(homeModelProvider.isError == true){
                Fluttertoast.showToast(
                    msg: AppStrings.thisCardItUsedTryAnotherOne.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                homeModelProvider.isError = false;
              }
              if(homeModelProvider.isSuccess == true){
                if(homeModelProvider.errorMessage == null){
                  homeModelProvider.startLoading();
                }
                Fluttertoast.showToast(
                    msg: "${homeModelProvider.errorMessage}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                value.initializeHomeScreen(context);
                homeModelProvider.isSuccess = false;
              }
              if(!value.isLoading){
                totalPoints = value.userSettings2!.points!.available;
                // value.userSettings2!.balance!.forEach((key, balance) {
                //   totalPoints = balance.available;
                // });
              }
              return (value.userSettings != null && value.userSettings2 != null && !notificationProviderModel.isGetNotificationLoading)?
              Scaffold(
                backgroundColor: const Color(0xffFFFFFF),
                body:
                SafeArea(
                  child: GradientBgImage(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              expandedHeight: height * 0.35,
                              pinned: true,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: LayoutBuilder(builder:
                                  (BuildContext context, BoxConstraints constraints) {
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
                                            gapH36,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: defaultProfileContainer(
                                                      imageUrl: '${value.userSettings!.photo}',
                                                      userName: "${value.userSettings!.name}",
                                                      userRole: value.userSettings!.role![0],
                                                      context: context),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    context.pushNamed(AppRoutes.notification.name,
                                                        pathParameters: {'lang': context.locale.languageCode,});
                                                  },
                                                  child: SvgPicture.asset(
                                                    AppImages.notification,
                                                    width: AppSizes.s30,
                                                    height: AppSizes.s30,
                                                  ),
                                                )
                                              ],
                                            ),
                                            gapH24,
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                     Text(
                                                      AppStrings.myPointsEarned.tr().toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color(AppColors.textC5)),
                                                    ),
                                                    gapW4,
                                                    GestureDetector(
                                                      onTap: (){
                                                        context.pushNamed(AppRoutes.painterPointsViewScreen.name,
                                                            pathParameters: {'lang': context.locale.languageCode,});
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppImages.questionMark,
                                                        width: AppSizes.s26,
                                                        height: AppSizes.s26,
                                                      ),
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
                                                    Text(
                                                      totalPoints.toString(),
                                                      style:const TextStyle(
                                                          fontSize: 32,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color(AppColors.textC5)),
                                                    ),
                                                    gapW10,
                                                     Text(
                                                      AppStrings.points.tr().toUpperCase(),
                                                      style: const TextStyle(
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
                                    DefaultTextFieldCodeSendNow()
                                  ],
                                );
                              }),
                            ),
                            PainterGrideView(),
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
                                            AppStrings.lastedNotifications.tr().toUpperCase(),
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
                                        padding: const EdgeInsets.only(bottom: AppSizes.s12),
                                        separatorBuilder: (context, index) => const SizedBox(height: 18,),
                                        itemCount: (notificationProviderModel.notifications.length > 4)? 4 : notificationProviderModel.notifications.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            PainterNotificationListViewItem(
                                              index: index,
                                              notifications: notificationProviderModel.notifications,
                                            )
                                    ),
                                    gapH82,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (homeModelProvider.gif == true)
                          Image.asset(
                            'assets/images/png/coin.gif',
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.5,
                            fit: BoxFit.fill,
                          )
                      ],
                    ),
                  ),
                ),
              ):HomePainterLoadingPage();
            },
            );
          },
        );
      },
    ),
    );
  }
}
