import 'package:app/feature/premium/data/source/premium_remote_service.dart';
import 'package:app/shared/data/service/session_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../shared/data/model/session_premium_service_model.dart';
import '../../data/model/premium_user_check_remote_post_model.dart';
import '../../data/model/premium_user_check_remote_response_model.dart';

abstract class PremiumRepository {
  final IPremiumRemoteService remoteService;
  final ISessionService sessionService;

  const PremiumRepository(
      {required this.sessionService, required this.remoteService});

  Future<Either<HiveFailure, void>> savePremiumInfoSession(
      SessionPremiumServiceModel model);

  Either<HiveFailure, SessionPremiumServiceModel> getPremiumInfoSession();

  Future<Either<HiveFailure, void>> clearPremiumInfoSession();

  Future<Either<Failure, PremiumUserCheckRemoteResponseModel>>
      checkPremiumRemote(
          {required String token,
          required PremiumUserCheckRemotePostModel model});

  Future<Either<HiveFailure, void>> savePremiumPopupViewDate(DateTime model);

  Either<HiveFailure, DateTime> getPremiumPopupViewDate();

  Future<Either<HiveFailure, void>> clearPremiumPopupViewDate();
}
