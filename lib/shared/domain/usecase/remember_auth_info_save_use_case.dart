import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the remember auth info,
/// like email/phone or any other info that the user choose to remember.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the remember auth info.
class RememberAuthInfoSaveUseCase
    implements UseCase<void, RememberAuthInfoSaveParams> {
  final CommonRepository repository;

  const RememberAuthInfoSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RememberAuthInfoSaveParams params) async {
    return await repository.saveRememberAuthInfo(params.authInfo);
  }
}

class RememberAuthInfoSaveParams {
  final String authInfo;

  const RememberAuthInfoSaveParams({required this.authInfo});
}
