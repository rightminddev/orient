import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/painter/teams/services/teams.service.dart';

class TeamsActionsViewModel extends ChangeNotifier {
  String? orderStatus;
  String? selectNewOwner;
  bool isLoading = false;
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
      ) async {
    try {
      isLoading = true;
      DioHelper.postData(
          url: "/rm_social/v1/team",
          context: context,
          data: {
            "name": name,
            "about": about
          }
      ).then((value){
        createTeamSuccess = true;
        isLoading = false;
        print(value.data);
      });
    } catch (err, t) {
      isLoading = false;
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
        notifyListeners();
        print(value.data);
      });
    } catch (err, t) {
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
    try {
      final result = await TeamsService.approveRequest(
        context: context,
        teamId: teamId,
        userId: userId,
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
  

  Future<void> leaveTeam({
    BuildContext? context,
    int? teamId,
    int? newOwnerId,
  }) async {
    try {
      isLoading = true;
      DioHelper.postData(url: "/rm_social/v1/team/leave",
          data: {
        "team_id": teamId,
 if(newOwnerId != null) "new_owner_id": newOwnerId
          }
      ).then((value){
        isLoading = false;
        leaveTeamSuccess = true;
        print(value.data);
      });
    } catch (err, t) {
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
    try {
      final result = await TeamsService.deleteUser(
        context: context,
        teamId: teamId,
        userId: userId,
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
