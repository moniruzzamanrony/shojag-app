import 'package:app/core/utils/extension/string_extension.dart';
import 'package:app/feature/premium/data/model/premium_user_check_remote_post_model.dart';
import 'package:app/feature/premium/domain/entity/premium_entity.dart';
import 'package:app/feature/premium/domain/repository/premium_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/data_state.dart';
import '../../../../../core/usecase/usecase.dart';

class PremiumServiceCheckUseCase
    implements UseCase<PremiumEntity, PremiumServiceCheckParams> {
  final PremiumRepository repository;

  const PremiumServiceCheckUseCase(this.repository);

  @override
  Future<Either<Failure, PremiumEntity>> call(
      PremiumServiceCheckParams params) async {
    final response = await repository.checkPremiumRemote(
        token: params.token,
        model: PremiumUserCheckRemotePostModel(userId: params.userId));
    return response.fold((l) => Left(l), (r) {
      return Right(PremiumEntity(
          isPremium: r.isPremium == 1,
          expireDate: r.premiumExpireAt?.toDateTime ?? DateTime(1970),
          currentPackage: '' // TODO: update in next package info
          ));
    });
  }
}

class PremiumServiceCheckParams {
  final String token;
  final int userId;

  const PremiumServiceCheckParams({
    required this.token,
    required this.userId,
  });
}
