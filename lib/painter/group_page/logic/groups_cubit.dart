import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/group_page/data/models/groups_model.dart';
import 'package:orient/painter/group_page/data/repositories/get_social_groups_repository.dart';

import 'groups_state.dart';



class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(this.getSocialGroupsRepository) : super(GroupsInitialState());

  final GetSocialGroupsRepository getSocialGroupsRepository;
  static GroupsCubit get(BuildContext context) => BlocProvider.of(context);

  GroupResponse? groupResponse;
  Future<void> getGroups() async {
    emit(GetGroupsLoadingState());
    Either<Failure, GroupResponse> result;
    result = await getSocialGroupsRepository.getSocialGroups() ;
    result.fold((failure) {
      emit(GetGroupsFailureState(failure.error));
    }, (groupResponse) {
      this.groupResponse = groupResponse;
      emit(GetGroupsSuccessState(groupResponse));
    });
  }
}
