import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/url_launcher.service.dart';
import 'package:orient/modules/shared_more_screen/contactus/model.dart';

class GeneralController extends ChangeNotifier{
  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;

  var dataTitle;
  var dataContent;
  var dataimage;
  getGeneralData(context, {slug}){
    isLoading = true;
    notifyListeners();
    DioHelper.getData(
      url: "/rm_page/v1/show",
      query: {
        "slug":slug
      },
      sendLang: true,
      context : context,
    ).then((value){
      dataTitle = value.data['page']['title'];
      dataContent = value.data['page']['content'];
      if(value.data['page']['cover_mobile'] != null &&value.data['page']['cover_mobile'].isNotEmpty){
        dataimage = value.data['page']['cover_mobile'][0]['file'];
      }
      isLoading = false;
      notifyListeners();
    }).catchError((error){
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      isLoading = false;
    });
  }
}

