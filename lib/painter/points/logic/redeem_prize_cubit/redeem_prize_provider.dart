import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/errors/failures.dart';
import '../../data/models/redeem_prize_model.dart';
import '../../data/repositories/redeem_prize_repository/redeem_prize_repository.dart';

enum RedeemPrizeStatus { initial, loading, success, failure }

class RedeemPrizeProvider extends ChangeNotifier {
  final RedeemPrizeRepository redeemPrizeRepository;

  RedeemPrizeProvider(this.redeemPrizeRepository);

  RedeemPrizeStatus _status = RedeemPrizeStatus.initial;
  RedeemPrizeStatus get status => _status;

  RedeemPrizeModel? _redeemPrizeModel;
  RedeemPrizeModel? get redeemPrizeModel => _redeemPrizeModel;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> redeemPrize({required String prizeName}) async {
    _status = RedeemPrizeStatus.loading;
    _errorMessage = null;
    notifyListeners();

    Either<Failure, RedeemPrizeModel> result = await redeemPrizeRepository.redeemPrize(prizeName: prizeName);

    result.fold((failure) {
      _status = RedeemPrizeStatus.failure;
      _errorMessage = failure.error;
      notifyListeners();
    }, (redeemPrizeModel) {
      _status = RedeemPrizeStatus.success;
      _redeemPrizeModel = redeemPrizeModel;
      notifyListeners();
    });
  }
}
