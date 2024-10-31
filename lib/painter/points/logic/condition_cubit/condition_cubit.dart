import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/errors/failures.dart';

import '../../data/models/condition_model.dart';
import '../../data/repositories/condition_repository/condition_repository.dart';
import 'condition_state.dart';


class ConditionCubit extends Cubit<ConditionState> {
  ConditionCubit(this.getConditionRepository) : super(ConditionInitialState());

  final ConditionRepository getConditionRepository;
  static ConditionCubit get(BuildContext context) =>
      BlocProvider.of(context);

  TermsAndConditionsModel? termsAndConditionsModel;
  Future<void> getCondition() async {
    emit(GetConditionLoadingState());
    Either<Failure, TermsAndConditionsModel> result;
    result = await getConditionRepository.getCondition();
    result.fold((failure) {
      print(failure.error);
      emit(GetConditionFailureState(failure.error));
    }, (termsAndConditionsModel) {
      this.termsAndConditionsModel = termsAndConditionsModel;
      emit(GetConditionSuccessState(termsAndConditionsModel));
    });
  }
}
