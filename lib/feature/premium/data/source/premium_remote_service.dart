import 'package:app/feature/premium/data/model/premium_user_check_remote_post_model.dart';
import 'package:app/feature/premium/data/model/premium_user_check_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/utils/constants/api_constants.dart';

abstract class IPremiumRemoteService {
  final BaseApiService apiService;

  const IPremiumRemoteService(this.apiService);

  Future<Either<Failure, PremiumUserCheckRemoteResponseModel>> checkPremium({
    required String token,
    required PremiumUserCheckRemotePostModel model,
  });
}

class PremiumRemoteService extends IPremiumRemoteService {
  PremiumRemoteService(super.apiService);

  @override
  Future<Either<Failure, PremiumUserCheckRemoteResponseModel>> checkPremium({
    required String token,
    required PremiumUserCheckRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.premiumCheckEndPoint,
      data: model.toMap(),
      fromJson: PremiumUserCheckRemoteResponseModel.fromJson,
    );
  }
}
