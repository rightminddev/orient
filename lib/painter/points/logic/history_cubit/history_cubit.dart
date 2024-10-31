import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orient/painter/points/logic/history_cubit/history_state.dart';

import '../../../core/errors/failures.dart';
import '../../data/models/history_model.dart';
import '../../data/repositories/history_repository/get_history_repository.dart';


class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.getHistoryRepository) : super(HistoryInitialState());

  final GetHistoryRepository getHistoryRepository;
  static HistoryCubit get(BuildContext context) =>
      BlocProvider.of(context);

  HistoryModel? historyModel;
  Future<void> getHistory() async {
    emit(GetHistoryLoadingState());
    Either<Failure, HistoryModel> result;
    result = await getHistoryRepository.getHistory();
    result.fold((failure) {
      print(failure.error);
      emit(GetHistoryFailureState(failure.error));
    }, (historyModel) {
      this.historyModel = historyModel;
      emit(GetHistorySuccessState(historyModel));
    });
  }
}
