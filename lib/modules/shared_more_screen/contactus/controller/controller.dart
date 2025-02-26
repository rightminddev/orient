import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/url_launcher.service.dart';
import 'package:orient/modules/shared_more_screen/contactus/model.dart';

class ContactUsController extends ChangeNotifier{
 bool isLoading = false;
 bool isSuccess = false;
 String? errorMessage;


 Future<void> sendMailToCompany(
     {required BuildContext context,
       required String email,
       required String? subject,
       required String? body}) async {
   if (email.isEmpty) return;
   final Uri params = Uri(
     scheme: 'mailto',
     path: email,
     query: 'subject=${subject ?? 'Contact From Application'}&body=${body ?? 'Hello'}',
   );
   var url = params.toString();
   await UrlLauncherServiceEx.launch(context: context, url: url);
 }
}

