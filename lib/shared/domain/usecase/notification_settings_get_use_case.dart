import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the notification settings,
/// typically used to determine if notifications are enabled or disabled.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// get the notification settings.
class NotificationSettingsGetUseCase
    implements UseCaseWithOutFuture<bool, NoParams> {
  final CommonRepository repository;

  NotificationSettingsGetUseCase(this.repository);

  @override
  Either<Failure, bool> call(NoParams params) {
    final session = repository.getNotificationSettings();
    return session.fold((l) => Left(l), (r) => Right(r.isOn));
  }
}
