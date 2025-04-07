import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/painter/core/errors/failures.dart';

import '../data/models/groups_model.dart';
import '../data/repositories/get_social_groups_repository.dart';

enum GroupsStatus { initial, loading, success, failure }

class GroupsProvider extends ChangeNotifier {

  GroupsStatus _status = GroupsStatus.initial;
  GroupsStatus get status => _status;

  GroupResponse? _groupResponse;
  GroupResponse? get groupResponse => _groupResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getGroups(context) async {
    _status = GroupsStatus.loading;
    _errorMessage = null;
    notifyListeners();
    DioHelper.getData(
        url: "/social-groups/entities-operations",
        context: context,
        query: {
          "with" : "posts"
        }
    ).then((value){
      if(value.data['status'] == true){
        _groupResponse = GroupResponse.fromJson(value.data);
        _status = GroupsStatus.success;
        print(value.data);
      }else{
        Fluttertoast.showToast(
            msg: value.data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        _status = GroupsStatus.failure;
      }
      notifyListeners();
    }).catchError((e){
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      _status = GroupsStatus.failure;
      _errorMessage = e.toString();
      print("ERROR -> ${e.toString()}");
    });
  }
}
