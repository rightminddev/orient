

import '../../data/models/condition_model.dart';

abstract class ConditionState {}

class ConditionInitialState extends ConditionState {}
class GetConditionLoadingState extends ConditionState {}
class GetConditionSuccessState extends ConditionState {
  final TermsAndConditionsModel termsAndConditionsModel;
  GetConditionSuccessState(this.termsAndConditionsModel);
}
class GetConditionFailureState extends ConditionState {
  final String error;
  GetConditionFailureState(this.error);
}
