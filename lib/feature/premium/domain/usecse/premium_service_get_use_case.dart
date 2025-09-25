import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/data_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/premium_entity.dart';
import '../repository/premium_repository.dart';

class PremiumServiceGetUseCase
    implements UseCaseWithOutFuture<PremiumEntity, NoParams> {
  final PremiumRepository repository;

  const PremiumServiceGetUseCase(this.repository);

  @override
  Either<Failure, PremiumEntity> call(NoParams params) {
    final session = repository.getPremiumInfoSession();
    return session.fold(
      (l) => Left(l),
      (r) {
        return Right(PremiumEntity(
            isPremium: r.isPremium,
            expireDate: r.expireDate,
            currentPackage: r.currentPackage));
      },
    );
  }
}
