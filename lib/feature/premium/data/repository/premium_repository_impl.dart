import 'package:app/core/error/data_state.dart';
import 'package:app/feature/premium/data/model/premium_user_check_remote_post_model.dart';
import 'package:app/feature/premium/data/model/premium_user_check_remote_response_model.dart';
import 'package:app/feature/premium/domain/repository/premium_repository.dart';
import 'package:app/shared/data/model/session_premium_service_model.dart';
import 'package:fpdart/fpdart.dart';

class PremiumRepositoryImpl extends PremiumRepository {
  PremiumRepositoryImpl(
      {required super.remoteService, required super.sessionService});

  @override
  Future<Either<HiveFailure, void>> clearPremiumInfoSession() {
    return sessionService.clearPremiumInfo();
  }

  @override
  Either<HiveFailure, SessionPremiumServiceModel> getPremiumInfoSession() {
    return sessionService.getPremiumInfo();
  }

  @override
  Future<Either<HiveFailure, void>> savePremiumInfoSession(
      SessionPremiumServiceModel model) {
    return sessionService.savePremiumInfo(model);
  }

  @override
  Future<Either<Failure, PremiumUserCheckRemoteResponseModel>>
      checkPremiumRemote(
          {required String token,
          required PremiumUserCheckRemotePostModel model}) {
    return remoteService.checkPremium(token: token, model: model);
  }

  @override
  Future<Either<HiveFailure, void>> clearPremiumPopupViewDate() {
    return sessionService.clearPremiumPopupViewDate();
  }

  @override
  Either<HiveFailure, DateTime> getPremiumPopupViewDate() {
    return sessionService.getPremiumPopupViewDate();
  }

  @override
  Future<Either<HiveFailure, void>> savePremiumPopupViewDate(DateTime model) {
    return sessionService.savePremiumPopupViewDate(model);
  }
}
