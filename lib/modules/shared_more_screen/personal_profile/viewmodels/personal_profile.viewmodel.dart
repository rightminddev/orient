import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orient/common_modules_widgets/custom_elevated_button.widget.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/date.service.dart';
import 'package:orient/general_services/image_file_picker.service.dart';
import 'package:orient/general_services/layout.service.dart';
import 'package:orient/general_services/settings.service.dart';
import 'package:orient/general_services/validation_service.dart';
import 'package:orient/models/settings/user_settings.model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/personal_profile.service.dart';

class PersonalProfileViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isSuccess = false;
  bool isSuccessUpdate = false;
  String? errorMessage;
  UserSettingsModel? userData;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController passwordForRemoveAccountController =
      TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  String? initialCountry;
  DateTime? birthDate;
  List<XFile>? selectedAvatar = [];
  final GlobalKey<FormState> form1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> form2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> form3Key = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  final double pageLeftRightPadding = AppSizes.s14;
  final double backgroundHeight = AppSizes.s270;
  final double notchedContainerHeight = AppSizes.s200;
  final double notchRadius = AppSizes.s50;
  final double notchPadding = AppSizes.s4;

  @override
  void dispose() {
    emailController.dispose();
    phoneNumberController.dispose();
    nameController.dispose();
    birthDateController.dispose();
    passwordForRemoveAccountController.dispose();
    countryCodeController.dispose();
    scrollController.dispose();
    super.dispose();
  }
  updatePassword({context,password}){
    isLoading = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_users/v1/update_password",
         context: context,
         data: {
          "password" : password
         }
    ).then((value){
      print(value.data);
      isLoading = false;
      notifyListeners();
      if(value.data['errors'] !=null){
        AlertsService.error(
            context: context,
            message: value.data['errors']['password'][0] !,
            title: 'FAILED');
      }else{
        isSuccess = true;
      AlertsService.success(
          context: context,
          message: 'UPDATED SUCCESSFULLY',
          title: 'SUCCESS');}
    }).catchError((error){ isLoading = false;
    AlertsService.error(
        context: context,
        message: "ERROR PLEASE TRY AGAIN"!,
        title: 'FAILED');
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      AlertsService.error(
          context: context,
          message: errorMessage!,
          title: 'FAILED');
    });
  }
  Future<void> initializePersonalProfileScreen(
      {required BuildContext context}) async {
    updateLoading(true);
    // First get current user Data
    userData = AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context) as UserSettingsModel?;
    //set initial values for fields
    print("USER -> ${userData!.name}");
    setInititalValues();
    updateLoading(false);
  }

  setInititalValues() {
    if (userData == null) return;
    emailController.text = userData?.email ?? '';
    phoneNumberController.text = userData?.phone ?? '';
    nameController.text = userData?.name ?? '';
    birthDateController.text = userData?.birthDate == null ? ""
        : DateService.formatDateTime(userData?.birthDate);
    print("date is ${birthDateController.text}");
    print("date is ${userData?.birthDate}");
  }

  void updateLoading(bool newVal) {
    isLoading = newVal;
    notifyListeners();
  }
  List listProfileImage = [];
  List<XFile> listXProfileImage = [];
  XFile? XImageFileProfile;
  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImageByCam(
      {image1, image2, list, list2}) async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.camera);
    if (imageFileProfile == null) return;
      image1 = File(imageFileProfile.path);
      image2 = imageFileProfile;
      list.add({"image": image2, "view": image1});
      list2.add(image2);
    notifyListeners();
    print(image1);
  }

  Future<void> getProfileImageByGallery(
      {image1, image2, list, list2}) async {
    XFile? imageFileProfile =
    await picker.pickImage(source: ImageSource.gallery);
    if (imageFileProfile == null) return null;
      image1 = File(imageFileProfile.path);
      image2 = imageFileProfile;
      list.add({"image": image2, "view": image1});
      list2.add(image2);
    notifyListeners();
  }
  Future<void> getImage(context,{image1, image2, list, bool one = true, list2}) =>
      showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "selectPhoto",
                      style: TextStyle(
                          fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                await getProfileImageByGallery(

                                    image1: image1,
                                    image2: image2,
                                    list: list,
                                    list2: list2
                                );
                                await image2 == null
                                    ? null
                                    : Image.asset(
                                    "assets/images/profileImage.png");
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await getProfileImageByCam(
                                    image1: image1,
                                    image2: image2,
                                    list: list,
                                    list2: list2
                                );
                                print(image1);
                                print(image2);
                                await image2 == null
                                    ? null
                                    : Image.asset(
                                    "assets/images/profileImage.png");
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: userData?.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != birthDate) {
      birthDate = picked;
      birthDateController.text = DateService.formatDateTime(birthDate, format: 'yyyy-MM-dd');
    }
    notifyListeners();
  }

  Future<void> activate2FA({required BuildContext context}) async {
    try {
      bool isActivate2FA = await AlertsService.confirmMessage(
          context, 'Activate 2FA',
          message: 'Are you sure you want to activate 2FA?');
      // if (userData?.emailVerifiedAt == null) {
      //   AlertsService.info(
      //       context: context,
      //       message: 'Email Verification is Required Before Activate 2FA',
      //       title: 'Info');
      //   return;
      // }
      if (isActivate2FA == false) return;
      final result = await PersonalProfileService.activateTfa(context: context);
      if (result.success) {
        // show dialog that contains qrcode of the serial and serial to connect to authenticaor app manualy
        String serial = result.data?['serial'];
        await _showQRCodeDialog(context, serial);
        return;
      } else {
        AlertsService.error(
            context: context,
            message:
                result.message ?? 'Failed To Activate 2FA , Please Try Later',
            title: 'Error');
        return;
      }
    } catch (ex, t) {
      debugPrint(
          'Failed to Activate 2FA , Please Try Later ,${ex.toString()} at $t');
      AlertsService.error(
          context: context,
          message: 'Failed To Activate 2FA , Please Try Later',
          title: 'Error');
    }
  }

  Future<void> _showQRCodeDialog(BuildContext context, String serial) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '2FA Activated Successfully',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: AppSizes.s200,
                height: AppSizes.s200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.s10),
                  child: QrImageView(
                    data: serial,
                    version: QrVersions.auto,
                    backgroundColor: Colors.transparent,
                    dataModuleStyle:
                        const QrDataModuleStyle(color: Colors.black),
                  ),
                ),
              ),
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(serial),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      FlutterClipboard.copy(serial).then((value) => {
                            AlertsService.success(
                                title: 'Serial copied !',
                                context: context,
                                message: 'Serial copied to clipboard')
                          });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUserSettingsData({required BuildContext context}) async {
    //update UserSettings 1,2
    await AppSettingsService.getUserSettingsAndUpdateTheStoredSettings(
        allData: true, context: context);
    // update user data
    await initializePersonalProfileScreen(context: context);
  }

  /// update profile
  Future<void> updateProfileMainInfo({required BuildContext context}) async {
    notifyListeners();
    try {
      //check if there is changes on the user profile
      if (nameController.text == userData?.name &&
          birthDateController.text ==
              DateService.formatDateTime(userData?.birthDate) &&
          selectedAvatar == null) {
        AlertsService.info(
            context: context,
            message: 'No changes detected, Profile is already up to date',
            title: 'Info');
        return;
      }
      // Vaidation
      if (form1Key.currentState?.validate() == true) {
        bool isUpdate = await AlertsService.confirmMessage(
            context, 'Update Profile',
            message: 'Are you sure you want to update your profile');
        print("UPDATE IS---> $isUpdate");
        if (isUpdate == false) return;

         var result = PersonalProfileService.updateProfile(
          context: context,
          name: nameController.text,
          avatar: listXProfileImage,
          birthDay: birthDateController.text ==
              DateService.formatDateTime(userData?.birthDate) ? birthDateController.text:DateService.formatDateTime(birthDate, format: 'yyyy-MM-dd'),
        );

          result.then((value)async{
            await updateUserSettingsData(context: context);
            AlertsService.success(
                title: 'Profile updated!',
                context: context,
                message: 'Profile updated successfully');
            isSuccessUpdate = true;
            print("Update2");
            print(value.data);
            notifyListeners();
            return;
          });
      }
    } catch (ex, t) {
      debugPrint(
          'Failed to update profile , Please Try Later ,${ex.toString()} at $t');
      AlertsService.error(
          context: context,
          message: 'Failed To update profile , Please Try Later',
          title: 'Error');
      notifyListeners();
    }
  }

  /// update profile email
  Future<void> updateProfileEmail({required BuildContext context}) async {
    try {
      //check if there is changes on the user profile email
      if (emailController.text == userData?.email) {
        AlertsService.info(
            context: context,
            message: 'No changes detected, Email is already up to date',
            title: 'Info');
        return;
      }
      // Vaidation
      if (form2Key.currentState?.validate() == true) {
        bool isUpdate = await AlertsService.confirmMessage(
            context, 'Update Email',
            message: 'Are you sure you want to update your email');

        if (isUpdate == false) return;
        final result = await PersonalProfileService.updateProfile(
            context: context, email: emailController.text);
        if (result.success &&
            result.data?['email_code'] == true &&
            result.data?['email_code_uuid'] != null &&
            result.data?['email_code_uuid'] != '') {
          return await _showEmailVerificationPopup(
              context: context,
              newEmail: emailController.text,
              emailUuid: result.data?['email_code_uuid']);
        }
      }
    } catch (ex, t) {
      debugPrint(
          'Failed to update email , Please Try Later ,${ex.toString()} at $t');
      AlertsService.error(
          context: context,
          message: 'Failed To update email , Please Try Later',
          title: 'Error');
      return;
    }
  }

  /// update profile phone number
  Future<void> updateProfilePhoneNumber({required BuildContext context}) async {
    try {
      //check if there is changes on the user profile phone
      if (phoneNumberController.text == userData?.phone) {
        AlertsService.info(
            context: context,
            message: 'No changes detected, Phone Number is already up to date',
            title: 'Info');
        return;
      }
      // Vaidation
      if (phoneNumberController.text.isEmpty) {
        AlertsService.warning(
            context: context,
            message: 'Please Provide Valid Phone Number',
            title: 'Warning');
        return;
      }

      bool isUpdate = await AlertsService.confirmMessage(
          context, 'Update Phone Number',
          message: 'Are you sure you want to update your Phone Number?');
      if (isUpdate == false) return;
      final result = await PersonalProfileService.updateProfile(
          context: context,
          phone: phoneNumberController.text,
          countryKey: '+20');
      if (result.success &&
          result.data?['phone_code'] == true &&
          result.data?['phone_code_uuid'] != null &&
          result.data?['phone_code_uuid'] != '') {
        return await _showPhoneVerificationPopup(
            context: context,
            newPhoneNumber: phoneNumberController.text,
            phoneUuid: result.data?['phone_code_uuid']);
      }
    } catch (ex, t) {
      debugPrint(
          'Failed to update email , Please Try Later ,${ex.toString()} at $t');
      AlertsService.error(
          context: context,
          message: 'Failed To update email , Please Try Later',
          title: 'Error');
      return;
    }
  }

  ///LOGOUT
  Future<void> logout({required BuildContext context}) async {
    try {
      bool isLogout = await AlertsService.confirmMessage(context, 'Log Out',
          message: 'Are you sure you want to log');
      if (isLogout == false) return;
      final result = await PersonalProfileService.logout(context: context);
      if (result.success) {
        // Clear user data and navigate to login screen
        final appConfigService =
            Provider.of<AppConfigService>(context, listen: false);
        await appConfigService.resetConfig();
        await appConfigService.setAuthenticationStatusWithToken(
            isLogin: false, token: null);
        return;
      } else {
        AlertsService.error(
            context: context,
            message: result.message ?? 'Failed To Logout , Please Try Later',
            title: 'Error');
        return;
      }
    } catch (ex, t) {
      debugPrint('Failed to Logout , Please Try Later ,${ex.toString()} at $t');
      AlertsService.error(
          context: context,
          message: 'Failed To Logout , Please Try Later',
          title: 'Error');
    }
  }

  // DELETE ACCOUNT
  Future<void> removeAccount({required BuildContext context}) async {
    try {
      if (form3Key.currentState?.validate() == false) return;
      bool isDeleteAccount = await AlertsService.confirmMessage(
          context, 'Delete Account',
          message: 'Are you sure you want to Delete Account');
      if (isDeleteAccount == false) return;
      final result = await PersonalProfileService.removeAccount(
          context: context, password: passwordForRemoveAccountController.text);
      if (result.success) {
        // Clear user data and navigate to login screen
        final appConfigService =
            Provider.of<AppConfigService>(context, listen: false);
        await appConfigService.resetConfig();
        await appConfigService.setAuthenticationStatusWithToken(
            isLogin: false, token: null);
        return;
      } else {
        AlertsService.error(
            context: context,
            message:
                result.message ?? 'Failed To Delete Account , Please Try Later',
            title: 'Error');
        return;
      }
    } catch (ex, t) {
      debugPrint(
          'Failed to Delete Account , Please Try Later ,${ex.toString()} at $t');
      AlertsService.error(
          context: context,
          message: 'Failed To Delete Account , Please Try Later',
          title: 'Error');
    }
  }

  // Phone Number Update Verification
  Future<void> _showPhoneVerificationPopup(
      {required BuildContext context,
      required String newPhoneNumber,
      required String phoneUuid}) async {
    TextEditingController codeController = TextEditingController();
    final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12),
          ),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(AppSizes.s16),
          titlePadding: const EdgeInsets.all(AppSizes.s16),
          contentPadding: const EdgeInsets.all(AppSizes.s12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OTP Verification',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: AppSizes.s32,
                    color: Colors.red,
                  ))
            ],
          ),
          content: SizedBox(
            width: LayoutService.getWidth(context),
            height: AppSizes.s300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.verificationCodeSent.tr(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                      textAlign: TextAlign.center,
                    ),
                    gapH12,
                    Text(
                      'A verification code has been sent to Your Phone Number',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Form(
                  key: codeFormKey,
                  child: TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppStrings.enterVerificationCode.tr(),
                    ),
                    validator: (value) =>
                        ValidationService.validateNumeric(value),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      title: AppStrings.verify.tr(),
                      onPressed: () async {
                        if (codeFormKey.currentState?.validate() == false) {
                          return;
                        }
                        final result =
                            await PersonalProfileService.updateProfile(
                                context: context,
                                phone: newPhoneNumber,
                                phoneCode: codeController.text,
                                phoneUuid: phoneUuid,
                                countryKey:
                                    countryCodeController.text.trim().isEmpty
                                        ? '+20'
                                        : countryCodeController.text.trim());
                        if (result.success) {
                          await updateUserSettingsData(context: context);
                          Navigator.of(context).pop(context);
                          AlertsService.success(
                              title: 'Phone Number updated!',
                              context: context,
                              message: 'Phone Number updated successfully');
                        } else {
                          Navigator.of(context).pop(context);
                          AlertsService.error(
                              title: 'Failed',
                              context: context,
                              message: result.message ??
                                  'Failed Verification Code , Please Try Later!');

                          return;
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Email Update Verification
  Future<void> _showEmailVerificationPopup(
      {required BuildContext context,
      required String newEmail,
      required String emailUuid}) async {
    TextEditingController codeController = TextEditingController();
    final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.s12),
          ),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(AppSizes.s16),
          titlePadding: const EdgeInsets.all(AppSizes.s16),
          contentPadding: const EdgeInsets.all(AppSizes.s12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Email Verification',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: AppSizes.s32,
                    color: Colors.red,
                  ))
            ],
          ),
          content: SizedBox(
            width: LayoutService.getWidth(context),
            height: AppSizes.s300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.verificationCodeSent.tr(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: AppSizes.s16),
                      textAlign: TextAlign.center,
                    ),
                    gapH12,
                    Text(
                      'A verification code has been sent to Your Email',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Form(
                  key: codeFormKey,
                  child: TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppStrings.enterVerificationCode.tr(),
                    ),
                    validator: (value) =>
                        ValidationService.validateNumeric(value),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      title: AppStrings.verify.tr(),
                      onPressed: () async {
                        if (codeFormKey.currentState?.validate() == false) {
                          return;
                        }
                        final result =
                            await PersonalProfileService.updateProfile(
                                context: context,
                                email: emailController.text,
                                emailCode: codeController.text,
                                emailUuid: emailUuid);
                        if (result.success) {
                          await updateUserSettingsData(context: context);
                          Navigator.of(context).pop(context);
                          AlertsService.success(
                              title: 'Email updated!',
                              context: context,
                              message: 'Email updated successfully');
                        } else {
                          Navigator.of(context).pop(context);
                          AlertsService.error(
                              title: 'Failed',
                              context: context,
                              message: result.message ??
                                  'Failed Verification Code , Please Try Later!');

                          return;
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
