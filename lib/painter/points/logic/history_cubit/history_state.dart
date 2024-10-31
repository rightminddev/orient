import '../../data/models/history_model.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}
class GetHistoryLoadingState extends HistoryState {}
class GetHistorySuccessState extends HistoryState {
  final HistoryModel historyModel;
  GetHistorySuccessState(this.historyModel);
}
class GetHistoryFailureState extends HistoryState {
  final String error;
  GetHistoryFailureState(this.error);
}
