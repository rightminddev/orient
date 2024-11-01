import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/errors/failures.dart';
import '../../data/models/history_model.dart';
import '../../data/repositories/history_repository/get_history_repository.dart';

enum HistoryState { initial, loading, success, failure }

class HistoryProvider with ChangeNotifier {
  final GetHistoryRepository getHistoryRepository;
  HistoryProvider(this.getHistoryRepository);

  HistoryState _state = HistoryState.initial;
  HistoryState get state => _state;

  HistoryModel? _historyModel;
  HistoryModel? get historyModel => _historyModel;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getHistory() async {
    _state = HistoryState.loading;
    notifyListeners();

    Either<Failure, HistoryModel> result = await getHistoryRepository.getHistory();

    result.fold((failure) {
      _errorMessage = failure.error;
      _state = HistoryState.failure;
      notifyListeners();
    }, (historyModel) {
      _historyModel = historyModel;
      _state = HistoryState.success;
      notifyListeners();
    });
  }
}
