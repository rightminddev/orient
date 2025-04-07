import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';

class PersonalInfoModelProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isUpdateProfileSuccess = false;
  String? errorMessage;
  DateTime? _selectedDate;
  var selectedDate;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(_selectedDate!);
      selectedDate = outputDate;
      notifyListeners();
      print(selectedDate);
    }
  }

  updateProfile({
    context,birth_day, name, email ,phone,default_language,
    avatar,email_uuid,email_code,country_key,phone_code,
    phone_uuid
  }) {
    isLoading = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_users/v1/update_profile",
        context: context,
        data: {
        if(birth_day != null || birth_day != "")  "birth_day" : birth_day,
          if(default_language != null || default_language != "") "default_language" : default_language,
          if(avatar != null || avatar != "") "avatar" : avatar,
          if(name != null || name != "") "name" : name,
          if(email != null || email != "") "email" : email,
          if(email_uuid != null || email_uuid != "") "email_uuid" : email_uuid,
          if(email_code != null || email_code != "") "email_code" : email_code,
          if(country_key != null || country_key != "") "country_key" : country_key,
          if(phone_code != null || phone_code != "") "phone_code" : phone_code,
          if(phone_uuid != null || phone_uuid != "")"phone_uuid" : phone_uuid,
          if(phone != null || phone != "") "phone" : phone
        }).then((value) {
      print(value.data);
      isLoading = false;
      isUpdateProfileSuccess =true;
      notifyListeners();
    }).catchError((error) {
      if (error is DioError) {
        errorMessage =
            error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
      isLoading = false;
      notifyListeners();
    });
  }
}
