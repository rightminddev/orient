import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/models/settings/app_settings_model.dart';
import 'package:orient/modules/shared_more_screen/remove_account/logic/account_delete_model.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_bottom_sheet.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class RemoveAccountScreen extends StatelessWidget {
 TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AccountDeleteModel(),
    child: Consumer<AccountDeleteModel>(
      builder: (context, value, child) {
        if(value.isDeleteSuccess == true){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final appConfigService =
            Provider.of<AppConfigService>(context, listen: false);
            appConfigService.logout().then((v){
              context.goNamed(AppRoutes.splash.name,
                  pathParameters: {'lang': context.locale.languageCode});
            });
            value.isDeleteSuccess = false;
          });
        }
        return Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          appBar: AppBar(
            backgroundColor: const Color(0xffFFFFFF),
            leading: const Icon(Icons.arrow_back, color: Color(0XFF224982),),
            title: Text(
              AppStrings.removeAccount.tr().toUpperCase(),
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
          body: GradientBgImage(
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Text(AppStrings.theAccountWillBeScheduledForDeletionWithIn60DaysYouWillStillBeAbleToLogInToCancelTheDeletionScheduleAtAnyTimeDuringThisPeriodOtherwiseTheDataWillBePermanentlyDeletedAfterThisPeriodEnds.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        height: 24/12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000)
                    ),
                  ),
                  const SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      defaultActionBottomSheet(
                        context: context,
                        textFormFieldController: passwordController,
                        title: AppStrings.confirmDeletion.tr().toLowerCase(),
                        viewHeaderIcon: false,widgetTextFormField: true,
                        textFormFieldHint: AppStrings.enterYourPassword.tr(),
                        subTitle: "",
                        onTapButton: (){
                          print("TPA");
                          value.deleteAccount(
                              context: context,
                              password: passwordController.text
                          );
                        },
                        buttonText: AppStrings.send.tr().toUpperCase(),
                        buttonWidget: ValueListenableBuilder<bool>(
                          valueListenable: value.isLoadingWidget,
                          builder: (context, isLoading, child) {
                            return isLoading ? const CircularProgressIndicator(color: Colors.white)
                                : Text(AppStrings.add.tr(),style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFFFFFF),
                                fontFamily: "Poppins"),);
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      decoration: BoxDecoration(
                        color: const Color(0xffBD1316),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/ecommerce/svg/apply_filter.svg"),
                          const SizedBox(width: 15,),
                          Text(
                            AppStrings.deleteAccount.tr().toUpperCase(),
                            style:const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFFFFFF)
                            ),
                          ),
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
    ),
    );
  }
}
