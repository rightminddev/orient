import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/points/data/models/redeem_prize_model.dart';
import 'package:orient/painter/points/logic/redeem_prize_cubit/redeem_prize_state.dart';
import '../../../core/errors/failures.dart';

import '../../data/repositories/redeem_prize_repository/redeem_prize_repository.dart';


class RedeemPrizeCubit extends Cubit<RedeemPrizeState> {
  RedeemPrizeCubit(this.redeemPrizeRepository) : super(RedeemPrizeInitialState());

  final RedeemPrizeRepository redeemPrizeRepository;
  static RedeemPrizeCubit get(BuildContext context) => BlocProvider.of(context);


  RedeemPrizeModel? redeemPrizeModel;
  Future<void> redeemPrize({required String prizeName}) async {
    emit(RedeemPrizeLoadingState());
    Either<Failure, RedeemPrizeModel> result;
    result = await redeemPrizeRepository.redeemPrize(prizeName: prizeName) ;
    result.fold((failure) {
      print(failure.error);
      emit(RedeemPrizeFailureState(failure.error));
    }, (redeemPrizeModel) {
      this.redeemPrizeModel = redeemPrizeModel;
      emit(RedeemPrizeSuccessState(redeemPrizeModel));
    });
  }
}
