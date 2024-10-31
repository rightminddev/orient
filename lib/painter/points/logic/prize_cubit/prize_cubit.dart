import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/points/data/models/copoun_model.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_state.dart';
import '../../../core/errors/failures.dart';
import '../../data/models/Prize_model.dart';
import '../../data/repositories/prize_repository/prize_repository.dart';


class PrizeCubit extends Cubit<PrizeState> {
  PrizeCubit(this.getPrizeRepository) : super(PrizeInitialState());

  final GetPrizeRepository getPrizeRepository;
  static PrizeCubit get(BuildContext context) => BlocProvider.of(context);


  String? prize;

  PrizeModel? prizeModel;
  Future<void> getPrize() async {
    emit(GetPrizeLoadingState());
    Either<Failure, PrizeModel> result;
    result = await getPrizeRepository.getPrize() ;
    result.fold((failure) {
      print(failure.error);
      emit(GetPrizeFailureState(failure.error));
    }, (prizeModel) {
      this.prizeModel = prizeModel;
      emit(GetPrizeSuccessState(prizeModel));
    });
  }


  CopounModel? copounModel;
  Future<void> sendCopoun({required String copounCode}) async {
    emit(SendCouponLoadingState());
    Either<Failure, CopounModel> result;
    result = await getPrizeRepository.sendCopoun(copounCode: copounCode) ;
    result.fold((failure) {
      print(failure.error);
      emit(SendCouponFailureState(failure.error));
    }, (copounModel) {
      this.copounModel = copounModel;
      emit(SendCouponSuccessState(copounModel));
    });
  }
}
