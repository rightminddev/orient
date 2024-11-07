import 'package:flutter/cupertino.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../data/models/condition_model.dart';
import '../../data/repositories/condition_repository/condition_repository.dart';

class ConditionProvider with ChangeNotifier {
  final ConditionRepository getConditionRepository;

  ConditionProvider(this.getConditionRepository);

  TermsAndConditionsModel? termsAndConditionsModel;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getCondition() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    Either<Failure, TermsAndConditionsModel> result =
    await getConditionRepository.getCondition();

    result.fold(
          (failure) {
        errorMessage = failure.error;
        isLoading = false;
        notifyListeners();
      },
          (termsAndConditionsModel) {
        this.termsAndConditionsModel = termsAndConditionsModel;
        isLoading = false;
        notifyListeners();
      },
    );
  }
}
