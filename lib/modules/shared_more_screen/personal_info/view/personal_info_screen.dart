import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/authentication/views/widgets/phone_number_field.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/shared_more_screen/personal_info/logic/personal_info_model.dart';
import 'package:orient/utils/components/general_components/all_text_field.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  HomeViewModel? homeViewModel;
  @override
  void initState() {
    homeViewModel = HomeViewModel();
    if(homeViewModel!.userSettings != null){
      if(homeViewModel!.userSettings!.phone != null){
        phoneController.text = homeViewModel!.userSettings!.phone ?? "";
      }if(homeViewModel!.userSettings!.email != null){
        emailController.text = homeViewModel!.userSettings!.email ?? "";
      }if(homeViewModel!.userSettings!.name != null){
        nameController.text = homeViewModel!.userSettings!.name ?? "";
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => PersonalInfoModelProvider(),
    child: Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Consumer<PersonalInfoModelProvider>(
          builder: (context, value, child) {
            return Scaffold(
              backgroundColor: const Color(0xffFFFFFF),
              appBar: AppBar(
                backgroundColor: const Color(0xffFFFFFF),
                leading: const Icon(Icons.arrow_back, color: Color(0XFF224982),),
                title: Text(
                  AppStrings.personalInfo.tr().toUpperCase(),
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
                      defaultTextFormFieldUpdate(
                          controller: phoneController,
                          hintText: AppStrings.phone.tr(),
                          onTap: (){}
                      ),
                      defaultTextFormFieldUpdate(
                          controller: emailController,
                          hintText: AppStrings.email.tr(),
                          onTap: (){}
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        hintText: AppStrings.email.tr(),
                      ),
                      buildTextFieldDate(
                          labelText: value.selectedDate ?? AppStrings.birthdate.tr().toUpperCase(),
                          onTap: (){
                            value.selectDate(context);
                          }
                      ),
                      PhoneNumberField(
                        controller: phoneController,
                        countryCodeController:countryCodeController ,
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: GestureDetector(
                          onTap: (){
                            value.updateProfile(
                              context: context,
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              birth_day: value.selectedDate
                            );
                          },
                          child: Container(
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
                      ),
                    ],
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
