import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:orient/painter/core/errors/failures.dart';

import '../data/models/groups_model.dart';
import '../data/repositories/get_social_groups_repository.dart';

enum GroupsStatus { initial, loading, success, failure }

class GroupsProvider extends ChangeNotifier {
  final GetSocialGroupsRepository getSocialGroupsRepository;

  GroupsProvider(this.getSocialGroupsRepository);

  GroupsStatus _status = GroupsStatus.initial;
  GroupsStatus get status => _status;

  GroupResponse? _groupResponse;
  GroupResponse? get groupResponse => _groupResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getGroups() async {
    _status = GroupsStatus.loading;
    _errorMessage = null;
    notifyListeners();

    Either<Failure, GroupResponse> result = await getSocialGroupsRepository.getSocialGroups();

    result.fold((failure) {
      _status = GroupsStatus.failure;
      _errorMessage = failure.error;
      notifyListeners();
    }, (groupResponse) {
      _status = GroupsStatus.success;
      _groupResponse = groupResponse;
      notifyListeners();
    });
  }
}
