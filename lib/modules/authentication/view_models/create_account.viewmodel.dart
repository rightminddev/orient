
import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/modules/home/view_models/user_cont.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/alert_service/alerts.service.dart';
import '../../../general_services/app_config.service.dart';
import '../auth_services/authentication.service.dart';

class CreateAccountViewModel extends ChangeNotifier {
  bool isLoading2 = false;
  bool notificationStatus = CacheHelper.getBool("status") ?? false;
  bool isSuccess = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController assignedByController = TextEditingController();
  final TextEditingController locationAddressController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEmailRegister = false;
  String? selectAccountType = CacheHelper.getString("role");
  DateTime? birthDate;
  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    countryCodeController.dispose();

    super.dispose();
  }
  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: UserSettingConst.userSettings?.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      locale:  const Locale('en', ''),
    );
    if (picked != null && picked != birthDate) {
      birthDate = picked;
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(birthDate!);
      birthDateController.text = outputDate;
      notifyListeners();
      print( birthDateController.text);
    }
  }
  getDeviceSysSet({context}) async {
    print("Zzzzzzzzzzzzzzzzzzzz");
    notifyListeners();
    final response = await DioHelper.postData(
      url: "/rm_users/v1/device_sys",
      context: context,
      data: {
        "action": "set",
        "key": "notification_token",
        "value": await FirebaseMessaging.instance.getToken(),
      },
    );
    CacheHelper.setBool("status", true);
    print("STATUS IS ---> ${CacheHelper.getBool("status")}");
    if(response.data['status'] == true){
      getDeviceSysSet2(context: context);
    }
    notifyListeners();
  }
  getDeviceSysSet2({context}) async {
    isLoading2 = true;
    notifyListeners();
    final response = await DioHelper.postData(
      url: "/rm_users/v1/device_sys",
      context: context,
      data: {
        "action": "set",
        "key": "notification_token_status",
        "value": true,
      },
    );
    if(response.data['status'] == true){
      isSuccess = true;
    }
    notificationStatus = true;
    CacheHelper.setBool("status", true);
    notifyListeners();
  }
  Future<void> createAccount({required BuildContext context, cityId, countryId, stateId, Function? making}) async {
   await getDeviceSysSet(context: context);
    try {
      if (phoneController.text.isEmpty) {
        AlertsService.warning(
            context: context,
            message: AppStrings.phoneNumberIsRequired.tr(),
            title: AppStrings.phoneNumber.tr());
        return;
      }
      if (formKey.currentState?.validate() == true) {
       if(CacheHelper.getString("role") != "merchant"){
         await _createNewAccount(
            phone: phoneController.text,
            email: emailController.text,
            birthDay: birthDateController.text,
            password: passwordController.text,
            name: nameController.text,
            mak: making,
            nationalId: nationalIdController.text,
            countryKey: countryCodeController.text.isEmpty
                ? '+20'
                : countryCodeController.text + phoneController.text,
            context: context,
            departmentId: 1);}
       else{
         if(assignedByController.text.isNotEmpty && assignedByController.text != null && assignedByController.text != ""){
          await _createNewAccount(
               phone: phoneController.text,
               email: emailController.text,
              birthDay: birthDateController.text,
               password: passwordController.text,
               name: nameController.text,
              mak: making,
               locationAddress: locationAddressController.text,
               countryKey: countryCodeController.text.isEmpty
                   ? '+20'
                   : countryCodeController.text + phoneController.text,
               context: context,
               stateId: stateId,
               nationalId: nationalIdController.text,
               countryId: countryId,
               cityId: cityId,
               assignedBy: assignedByController.text,
               departmentId: 1);
         }else{
           await _createNewAccount(
               phone: phoneController.text,
               email: emailController.text,
               birthDay: birthDateController.text,
               password: passwordController.text,
               name: nameController.text,
               mak: making,
               locationAddress: locationAddressController.text,
               countryKey: countryCodeController.text.isEmpty
                   ? '+20'
                   : countryCodeController.text + phoneController.text,
               context: context,
               stateId: stateId,
               nationalId: nationalIdController.text,
               countryId: countryId,
               cityId: cityId,
               departmentId: 1);
         }
       }
      } else {
        AlertsService.warning(
            context: context,
            message: AppStrings.formIsInvalid.tr(),
            title: AppStrings.formValidation.tr());
      }
      return;
    } catch (err, t) {
      debugPrint('Error :- $err in :- $t');
      AlertsService.warning(
          context: context,
          message: AppStrings.failedRegisterationPleaseTryAgain.tr(),
          title: AppStrings.failed.tr());

      return;
    }
  }

  Future<void> _createNewAccount(
      {required String name,
      required String phone,
      required String countryKey,
      required String password,
      required String email,
      required int departmentId,
        var stateId,
        var nationalId,
        var countryId,
        var locationAddress,
        var cityId,
        var birthDay,
        var assignedBy,
        var mak,
      required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    final result = await AuthenticationService.createAccount(
        context: context,
        name: name,
        phone: phone,
        birthDay: birthDay,
        locationAddress: locationAddress,
        registerAs: CacheHelper.getString("role"),
        countryKey: countryKey,
        password: password,
        assignedBy: assignedBy,
        cityId: cityId,
        countryId: countryId,
        nationalId: nationalId,
        stateId: stateId,
        email: email,
        departmentId: departmentId,
        deviceInformation: appConfigServiceProvider.deviceInformation.toMap());
    if (result.success) {
      if(mak == null) Navigator.pop(context, result);
      if(mak != null){mak();}
    } else {
      Fluttertoast.showToast(
          msg: result.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return;
    }
  }
}
