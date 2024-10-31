import 'package:orient/painter/points/data/models/redeem_prize_model.dart';


abstract class RedeemPrizeState {}

class RedeemPrizeInitialState extends RedeemPrizeState {}

class RedeemPrizeLoadingState extends RedeemPrizeState {}
class RedeemPrizeSuccessState extends RedeemPrizeState {
  final RedeemPrizeModel redeemPrizeModel;
  RedeemPrizeSuccessState(this.redeemPrizeModel);
}
class RedeemPrizeFailureState extends RedeemPrizeState {
  final String error;
  RedeemPrizeFailureState(this.error);
}
