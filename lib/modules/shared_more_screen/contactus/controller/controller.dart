import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/url_launcher.service.dart';
import 'package:orient/modules/shared_more_screen/contactus/model.dart';

class ContactUsController extends ChangeNotifier{
 bool isLoading = false;
 bool isSuccess = false;
 String? errorMessage;
 GeneralSettings? apiResponse;
 var phone;
 List hotPhone = [];
 var addressAr;
 var addressEn;
 var facebook;
 var instagram;
 var whatsApp;
 var twitter;
 var youtube;
 var linkedIn;
 List branchs = [];
 getGeneral(context){
   isLoading = true;
   notifyListeners();
   DioHelper.postData(
       url: "/rm_users/v1/start_app",
       context: context,
       data: {
         "needed": [
           "general_settings",
           "user_settings",
           "user2_settings",
           "check_auth"
         ]
       }
   ).then((value){
     isLoading = false;
     isSuccess = true;
     hotPhone = value.data['general_settings']['data']['company_contacts']['otherphones'];
     phone = value.data['general_settings']['data']['company_contacts']['phone'];
     addressEn = value.data['general_settings']['data']['company_contacts']!['branches']![0]['co_info_address']['en'];
     addressAr = value.data['general_settings']['data']['company_contacts']!['branches']![0]['co_info_address']['en'];
     facebook = value.data['general_settings']['data']['company_contacts']!['facebook'];
     instagram = value.data['general_settings']['data']['company_contacts']!['instagram'];
     whatsApp = value.data['general_settings']['data']['company_contacts']!['whatsapp'];
     twitter = value.data['general_settings']['data']['company_contacts']!['twitter'];
     youtube = value.data['general_settings']['data']['company_contacts']!['youtube'];
     youtube = value.data['general_settings']['data']['company_contacts']!['linkedin'];
     branchs = value.data['general_settings']['data']['company_contacts']!['branches'];
     apiResponse = GeneralSettings.fromJson(value.data);
     notifyListeners();
   }).catchError((e){
     isLoading = false;
     isSuccess = false;
     errorMessage = e.toString();
     notifyListeners();
   });
 }
 Future<void> sendMailToCompany(
     {required BuildContext context,
       required String email,
       required String? subject,
       required String? body}) async {
   if (email.isEmpty) return;
   final Uri params = Uri(
     scheme: 'mailto',
     path: email,
     query: 'subject=${subject ?? 'Contact Us'}&body=${body ?? 'Hello'}',
   );
   var url = params.toString();
   await UrlLauncherServiceEx.launch(context: context, url: url);
 }
}

