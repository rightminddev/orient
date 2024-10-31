import 'package:orient/painter/points/data/models/copoun_model.dart';

import '../../data/models/Prize_model.dart';

abstract class PrizeState {}

class PrizeInitialState extends PrizeState {}
class GetPrizeLoadingState extends PrizeState {}
class GetPrizeSuccessState extends PrizeState {
  final PrizeModel prizeModel;
  GetPrizeSuccessState(this.prizeModel);
}
class GetPrizeFailureState extends PrizeState {
  final String error;
  GetPrizeFailureState(this.error);
}

class SendCouponLoadingState extends PrizeState {}
class SendCouponSuccessState extends PrizeState {
  final CopounModel copounModel;
  SendCouponSuccessState(this.copounModel);
}
class SendCouponFailureState extends PrizeState {
  final String error;
  SendCouponFailureState(this.error);
}
