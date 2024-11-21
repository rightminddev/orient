import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/media_query_values.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/layout.service.dart';
import '../../../utils/overlay_gradient_widget.dart';
import '../view_models/login.viewmodel.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  AdminLoginScreenState createState() => AdminLoginScreenState();
}

class AdminLoginScreenState extends State<AdminLoginScreen>
    with SingleTickerProviderStateMixin {
  late AuthenticationViewModel viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = AuthenticationViewModel();
    viewModel.initializeAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationViewModel>(
        create: (context) => viewModel,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
            child: SingleChildScrollView(
              child: SizedBox(
                height: LayoutService.getHeight(context),
                width: LayoutService.getWidth(context),
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: viewModel.animation,
                      builder: (context, child) {
                        return Positioned.fill(
                          child: FractionallySizedBox(
                            widthFactor: AppSizes.s4,
                            alignment: Alignment(
                                (viewModel.animation.value * 2) - 1, 0),
                            child: Image.asset(
                              AppImages.splashScreenBackground,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    const OverlayGradientWidget(),
                    Center  (
                      child: Form(
                        key: viewModel.formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.s16),
                          child: SizedBox(
                            width: LayoutService.getWidth(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logo
                                Image.asset(
                                  AppImages.logo,
                                  width: AppSizes.s200,
                                  height: AppSizes.s70,
                                  fit: BoxFit.contain,
                                ),
                                gapH32,
                                // Login Page Headline
                                AutoSizeText(
                                  AppStrings.welcomeTo.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 36,
                                    color: Color(0xffFFFFFF)
                                  ),
                                ),
                                AutoSizeText(
                                  AppStrings.orientApp.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36,
                                      color: Color(0xffFFFFFF)
                                  ),
                                ),
                                gapH32,
                                defaultLoginContainer(
                                  appName: AppStrings.ecommerceStore.tr(),
                                  iconColor: const Color(0xffE6007E),
                                  onTap: (){
                                    context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                                        pathParameters: {'lang': context.locale.languageCode});
                                  },
                                  src: "assets/images/svg/e_icon.svg"
                                ),defaultLoginContainer(
                                  appName: AppStrings.paintersCommunity.tr(),
                                    iconColor: const Color(0xffC5B700),
                                    onTap: (){
                                      context.goNamed(AppRoutes.painterHomeScreen.name,
                                          pathParameters: {'lang': context.locale.languageCode});
                                    },
                                    src: "assets/images/svg/p_icon.svg"
                                ),defaultLoginContainer(
                                  appName: AppStrings.merchantsAndStores.tr(),
                                    iconColor: const Color(0xff0D3B6F),
                                    onTap: (){
                                      context.goNamed(AppRoutes.merchantHomeScreen.name,
                                          pathParameters: {'lang': context.locale.languageCode});
                                    },
                                    src: "assets/images/svg/m_icon.svg"
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  defaultLoginContainer({appName, onTap, iconColor ,src})=> GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10 ),
            decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(15)
            ),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.62,
              child: Text(
                "$appName".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xff224982),
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: SvgPicture.asset(src),
        )
      ],
    ),
  );
}
