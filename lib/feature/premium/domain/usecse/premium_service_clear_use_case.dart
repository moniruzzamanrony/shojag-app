import 'package:app/feature/premium/domain/repository/premium_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/data_state.dart';
import '../../../../../core/usecase/usecase.dart';

class PremiumServiceClearUseCase implements UseCase<void, NoParams> {
  final PremiumRepository repository;

  const PremiumServiceClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearPremiumInfoSession();
  }
}
