import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_colors.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/views/widgets/loading/home_body_loading.dart';
import 'package:orient/painter/home_screen/views/home_model.dart';
import 'package:orient/painter/painter/views/widgets/painter_gride_view.dart';
import 'package:orient/painter/painter/views/widgets/painter_notification_list_view.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
 TextEditingController codeController = TextEditingController();
 var totalPoints;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(create: (context) => HomeModelProvider(),
    child: Consumer<HomeModelProvider>(
      builder: (context, homeModelProvider, child) {
        return Consumer<HomeViewModel>(
          builder: (context, value, child) {
            if(homeModelProvider.isError == true){
              Fluttertoast.showToast(
                  msg: "This card it used try another one",
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
              print("IDS -> ${value.userSettings!.userTeam!.about}");
              value.userSettings2!.balance!.forEach((key, balance) {
                totalPoints = balance.available;
              });
            }
            return Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              body: (value.userSettings == null && value.userSettings2 == null)?
              HomeLoadingPage(viewAppbar: true)
                  : SafeArea(
                child: GradientBgImage(
                  padding: EdgeInsets.zero,
                  child: CustomScrollView(
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
                                              const Text(
                                                "MY POINTS EARNED",
                                                style: TextStyle(
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
                                    child: SizedBox(
                                      width: width * 0.75,
                                      height: AppSizes.s53,
                                      child: defaultTextFieldCodeSendNow(
                                        hintText: '1294-1256-5523-5520',
                                        controller: codeController,
                                        onTapButton: (){
                                          homeModelProvider.addRedeemGift(
                                            context: context,
                                            serial: codeController.text
                                          );
                                          codeController.clear();
                                        },
                                        logo: AppImages.painterCodeLogo,
                                      ),
                                    )
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
                              const PainterNotificationListView(),
                              gapH82,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
    );
  }
}