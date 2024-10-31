import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/points/logic/points_cubit/points_state.dart';



class PointsCubit extends Cubit<PointsState> {
  PointsCubit() : super(PointsInitialState());


  static PointsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }
}
