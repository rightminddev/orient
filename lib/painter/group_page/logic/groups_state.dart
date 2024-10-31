import 'package:orient/painter/group_page/data/models/groups_model.dart';

abstract class GroupsState {}

class GroupsInitialState extends GroupsState {}
class GetGroupsLoadingState extends GroupsState {}
class GetGroupsSuccessState extends GroupsState {
  final GroupResponse groupResponse;
  GetGroupsSuccessState(this.groupResponse);
}
class GetGroupsFailureState extends GroupsState {
  final String error;
  GetGroupsFailureState(this.error);
}