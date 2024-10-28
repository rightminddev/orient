import 'package:flutter/material.dart';
import 'package:orient/modules/teams/services/teams.service.dart';

class TeamsActionsViewModel extends ChangeNotifier {
  String? orderStatus;

  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> createTeam(
    BuildContext context,
    String name,
    String about,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _createTeam(
      context,
      name,
      about,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _createTeam(
    BuildContext context,
    String name,
    String about,
  ) async {
    try {
      final result = await TeamsService.createTeam(
        context: context,
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

  Future<void> joinTeam(
    BuildContext context,
    int teamId,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _joinTeam(
      context,
      teamId,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _joinTeam(
    BuildContext context,
    int teamId,
  ) async {
    try {
      final result = await TeamsService.joinTeam(
        context: context,
        teamId: teamId,
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

  Future<void> leaveTeam(
    BuildContext context,
    int teamId,
    int newOwnerId,
  ) async {
    updateLoadingStatus(laodingValue: true);
    await _leaveTeam(
      context,
      teamId,
      newOwnerId,
    );
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _leaveTeam(
    BuildContext context,
    int teamId,
    int newOwnerId,
  ) async {
    try {
      final result = await TeamsService.leaveTeam(
        context: context,
        teamId: teamId,
        newOwnerId: newOwnerId,
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
