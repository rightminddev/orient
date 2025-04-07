import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orient/painter/core/errors/failures.dart';
import 'package:orient/painter/points/data/models/copoun_model.dart';
import 'package:orient/painter/points/data/models/redeem_prize_model.dart';
import 'package:orient/painter/points/data/repositories/redeem_prize_repository/redeem_prize_repository.dart';


import '../../data/models/Prize_model.dart';
import '../../data/repositories/prize_repository/prize_repository.dart';
enum RedeemPrizeStatus { initial, loading, success, failure }

class PrizeProvider with ChangeNotifier {
  final GetPrizeRepository getPrizeRepository;

  PrizeProvider(this.getPrizeRepository ,this.redeemPrizeRepository);
  bool successSend = false;
  bool radeemPrize = false;
  // Define loading and error state variables
  bool isLoading = false;
  String? errorMessage;
  String? prize;

  // Define data models
  PrizeModel? prizeModel;
  CopounModel? copounModel;
  bool _isLoading = false;

  // Method to get prize details
  bool gif = false;
  void startLoading() {
    _isLoading = true;
    notifyListeners();
    Timer(const Duration(seconds: 2), () {
      _isLoading = false;
      gif = true;
      stopCoinGif();
      notifyListeners();
    });
  }

  stopCoinGif() {
    return Timer(const Duration(seconds: 5), () {
      gif = false;
      notifyListeners();
    });
  }
  Future<void> getPrize() async {
    _setLoadingState(true);
    final result = await getPrizeRepository.getPrize();

    result.fold(
          (failure) {
            Fluttertoast.showToast(
                msg: failure.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            _setErrorState(failure.error);
          },
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
          (failure){
            Fluttertoast.showToast(
                msg: failure.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            _setErrorState(failure.error);
          },
          (copounModel) {
        this.copounModel = copounModel;
        successSend = true;

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
  final RedeemPrizeRepository redeemPrizeRepository;
  bool isRadeem = false;

  RedeemPrizeStatus _status = RedeemPrizeStatus.initial;
  RedeemPrizeStatus get status => _status;

  RedeemPrizeModel? _redeemPrizeModel;
  RedeemPrizeModel? get redeemPrizeModel => _redeemPrizeModel;

  String? _errorMessages;
  String? get errorMessages => _errorMessages;

  Future<void> redeemPrize({required String prizeName}) async {
    _status = RedeemPrizeStatus.loading;
    _errorMessages = null;
    notifyListeners();

    Either<Failure, RedeemPrizeModel> result = await redeemPrizeRepository.redeemPrize(prizeName: prizeName);

    result.fold((failure) {
      _status = RedeemPrizeStatus.failure;
      _errorMessages = failure.error;
      Fluttertoast.showToast(
          msg: failure.error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      notifyListeners();
    }, (redeemPrizeModel) {
      _status = RedeemPrizeStatus.success;
      radeemPrize = true;
      isRadeem = true;
      _redeemPrizeModel = redeemPrizeModel;
      notifyListeners();
    });
  }
}
