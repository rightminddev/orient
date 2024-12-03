import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/shared_more_screen/personal_profile/viewmodels/personal_profile.viewmodel.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_strings.dart';

class UpdatePasswordScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => PersonalProfileViewModel(),
    child: Consumer<HomeViewModel>(
      builder: (context, values, child) {
        return Consumer<PersonalProfileViewModel>(
          builder: (context, value, child) {
            if(value.isSuccess){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final appConfigService =
                Provider.of<AppConfigService>(context, listen: false);
                appConfigService.logout().then((v){
                  context.goNamed(AppRoutes.splash.name,
                      pathParameters: {'lang': context.locale.languageCode});
                });
              });
            }
            return Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              appBar: AppBar(
                backgroundColor: const Color(0xffFFFFFF),
                leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, color: Color(0XFF224982),)),
                title: Text(
                  AppStrings.updatePassword.tr().toUpperCase(),
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
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 30),
                        child: Column(
                          children: [
                            defaultTextFormField(
                              hintText: AppStrings.newPassword.tr(),
                              controller: passwordController,
                            ),
                            const SizedBox(height: 30,),
                            if(value.isLoading) const Center(child: CircularProgressIndicator(),),
                            if(!value.isLoading) GestureDetector(
                              onTap: (){
                                value.updatePassword(context: context, password: passwordController.text);
                                passwordController.clear();
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff0D3B6F),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/images/ecommerce/svg/apply_filter.svg"),
                                    const SizedBox(width: 15,),
                                    Text(
                                      AppStrings.saveChanges.tr().toUpperCase(),
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
                        )
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    )
    );
  }
}
