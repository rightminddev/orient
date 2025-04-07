import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/painter/teams/services/teams.service.dart';

class TeamsActionsViewModel extends ChangeNotifier {
  String? orderStatus;
  String? selectNewOwner;
  bool isLoading = false;
  bool isLeaveLoading = false;
  bool isApproveSuccess = false;
  bool isRefusedSuccess = false;
  ValueNotifier<bool> isLoadingWidget = ValueNotifier(false);
  bool createTeamSuccess = false;
  bool joinTeamSuccess = false;
  bool leaveTeamSuccess = false;
  void dropDownOnChanged(value){
    selectNewOwner = value;
    notifyListeners();
  }
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  // Future<void> createTeam(
  //   BuildContext context,
  //   String name,
  //   String about,
  // ) async {
  //   updateLoadingStatus(laodingValue: true);
  //   await _createTeam(
  //     context,
  //     name,
  //     about,
  //   );
  //   createTeamSuccess = true;
  //   updateLoadingStatus(laodingValue: false);
  // }

  Future<void> createTeam(
      BuildContext context,
      String name,
      String about,
      List<XFile>? attachments,
      ) async {
    updateLoadingStatus(laodingValue:true);
    FormData formData = FormData.fromMap( {
      "name": name,
      "about": about,
      if(attachments != null && attachments.isNotEmpty)"image": attachments != null
          ? await Future.wait(attachments.map((file) async => await MultipartFile.fromFile(file.path, filename: file.name)).toList()) : null,
    });
    try {
      await DioHelper.postFormData(
          url: "/rm_social/v1/team",
          context: context,
          formdata: formData
      ).then((value){
        updateLoadingStatus(laodingValue:false);
        if(value.data['status'] == false){
          Fluttertoast.showToast(
              msg: value.data['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else{
          Fluttertoast.showToast(
              msg: value.data['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          createTeamSuccess = true;
        }
        print(value.data);
      });
    } catch (err, t) {
      updateLoadingStatus(laodingValue:false);
      Fluttertoast.showToast(
          msg: err.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> joinTeam(
    BuildContext context,
    int teamId,
  ) async {
    try {
      notifyListeners();
      isLoading = true;
      DioHelper.postData(
          url: "/rm_social/v1/team/join",
          context: context,
          data: {
            "team_id": teamId
          }
      ).then((value){
        isLoading = false;
        joinTeamSuccess = true;
        if(value.data['status'] == true){
          AlertsService.success(
              context: context,
              message: value.data['message'],
              title: AppStrings.successful.tr());
        } if(value.data['status'] == false){
          Fluttertoast.showToast(
              msg: value.data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        notifyListeners();
        print(value.data);
      });
    } catch (err, t) {
      Fluttertoast.showToast(
          msg: err.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      notifyListeners();
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> approveRequest(
    BuildContext context,
    int teamId,
    int userId,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _approveRequest(
      context,
      teamId,
      userId,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _approveRequest(
    BuildContext context,
    int teamId,
    int userId,
  ) async {
      isLoadingWidget.value = true;
      notifyListeners();
      DioHelper.postData(
          url: "/rm_social/v1/team/approve-request",
          context: context,
          data: {
            "team_id": teamId,
            "user_id": userId
          }
      ).then((value){
        if(value.data['status'] == true){
          AlertsService.success(
              context: context,
              message: value.data['message'],
              title: AppStrings.successful.tr());
        } if(value.data['status'] == false){
          Fluttertoast.showToast(
              msg: value.data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (value.data != null) {
          print(value.data);
          isLoadingWidget.value = false;
        }
        isApproveSuccess = true;
        notifyListeners();
      }).catchError((err){
        isLoadingWidget.value = false;
        Fluttertoast.showToast(
            msg: err.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        notifyListeners();
        debugPrint(
            "error while getting Employee Details  ${err.toString()} " );
      });
  }

var leaveStatus;
  Future<void> leaveTeam({
    BuildContext? context,
    int? teamId,
    var newOwnerId,
  }) async {
    try {
      isLeaveLoading = true;
      DioHelper.postData(url: "/rm_social/v1/team/leave",
          context: context,
          data: {
            "team_id": teamId,
             if(newOwnerId != null) "new_owner_id": newOwnerId
      }
      ).then((value){
        leaveStatus = value.data['status'];
        isLeaveLoading = false;
        if(value.data['status'] == false){
          Fluttertoast.showToast(
              msg:value.data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          leaveTeamSuccess = true;
        }
        if(value.data['status'] == true){
          Fluttertoast.showToast(
              msg:value.data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          leaveTeamSuccess = true;
        }
        print(value.data);
        notifyListeners();
      });
    } catch (err, t) {
      isLeaveLoading = false;
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> deleteUser(
    BuildContext context,
    int teamId,
    int userId,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _deleteUser(
      context,
      teamId,
      userId,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _deleteUser(
    BuildContext context,
    int teamId,
    int userId,
  ) async {
    isLoadingWidget.value = true;
    notifyListeners();
    DioHelper.postData(
        url: "/rm_social/v1/team/delete-member",
        context: context,
        data: {
          "team_id": teamId,
          "user_id": userId
        }
    ).then((value){
     if(value.data['status'] == true){
       AlertsService.success(
           context: context,
           message: value.data['message'],
           title: AppStrings.successful.tr());
     } if(value.data['status'] == false){
       Fluttertoast.showToast(
           msg: value.data['message'],
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 5,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
      if (value.data != null) {
        print(value.data);
        isLoadingWidget.value = false;
      }
      isRefusedSuccess = true;
      notifyListeners();
    }).catchError((err){
      isLoadingWidget.value = false;

      notifyListeners();
      debugPrint(
          "error while getting Employee Details  ${err.toString()} " );
    });
  }

  Future<void> updateTeam(
    BuildContext context,
    int teamId,
    String name,
    String about,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _updateTeam(
      context,
      teamId,
      name,
      about,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _updateTeam(
    BuildContext context,
    int teamId,
    String name,
    String about,
  ) async {
    try {
      final result = await TeamsService.updateTeam(
        context: context,
        teamId: teamId,
        name: name,
        about: about,
      );

      if (result.success && result.data != null) {
        // (result.data?['orders'] ?? []).forEach((v) {
        //   myOrders.add(OrderModel.fromJson(v));
        // });
      }
      //debugPrint(myOrders.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
