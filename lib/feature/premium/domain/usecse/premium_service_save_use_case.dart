import 'package:app/shared/data/model/session_premium_service_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/data_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../repository/premium_repository.dart';

class PremiumServiceSaveUseCase
    implements UseCase<void, PremiumServiceSaveParams> {
  final PremiumRepository repository;

  const PremiumServiceSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(PremiumServiceSaveParams params) async {
    return await repository.savePremiumInfoSession(SessionPremiumServiceModel(
        isPremium: params.isPremium,
        expireDate: params.expireDate,
        currentPackage: params.currentPackage));
  }
}

class PremiumServiceSaveParams {
  final bool isPremium;
  final DateTime expireDate;
  final String currentPackage;

  PremiumServiceSaveParams(
      {required this.isPremium,
      required this.expireDate,
      required this.currentPackage});
}
