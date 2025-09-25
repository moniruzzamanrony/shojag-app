import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for clearing the notification settings,
/// typically used when the user choose to disable notifications.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// clear the notification settings.
class NotificationSettingsClearUseCase implements UseCase<void, NoParams> {
  final CommonRepository repository;

  const NotificationSettingsClearUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearNotificationSettings();
  }
}
