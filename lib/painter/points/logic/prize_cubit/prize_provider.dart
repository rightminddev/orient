import 'package:flutter/material.dart';
import 'package:orient/painter/points/data/models/copoun_model.dart';


import '../../data/models/Prize_model.dart';
import '../../data/repositories/prize_repository/prize_repository.dart';

class PrizeProvider with ChangeNotifier {
  final GetPrizeRepository getPrizeRepository;

  PrizeProvider(this.getPrizeRepository);

  // Define loading and error state variables
  bool isLoading = false;
  String? errorMessage;
  String? prize;

  // Define data models
  PrizeModel? prizeModel;
  CopounModel? copounModel;

  // Method to get prize details
  Future<void> getPrize() async {
    _setLoadingState(true);
    final result = await getPrizeRepository.getPrize();

    result.fold(
          (failure) => _setErrorState(failure.error),
          (prizeModel) {
        this.prizeModel = prizeModel;
        _clearErrorState();
      },
    );
    _setLoadingState(false);
  }

  // Method to send coupon
  Future<void> sendCopoun({required String copounCode}) async {
    _setLoadingState(true);
    final result = await getPrizeRepository.sendCopoun(copounCode: copounCode);

    result.fold(
          (failure) => _setErrorState(failure.error),
          (copounModel) {
        this.copounModel = copounModel;
        _clearErrorState();
      },
    );
    _setLoadingState(false);
  }

  // Private method to set loading state
  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  // Private method to set error state
  void _setErrorState(String message) {
    errorMessage = message;
    notifyListeners();
  }

  // Private method to clear error state
  void _clearErrorState() {
    errorMessage = null;
    notifyListeners();
  }
}
