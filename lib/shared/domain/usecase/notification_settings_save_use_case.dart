import 'package:app/shared/data/model/session_notification_settings_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the notification settings,
/// typically used when the user tap on the notification switch.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the notification settings.
class NotificationSettingsSaveUseCase
    implements UseCase<void, NotificationSettingsSaveParams> {
  final CommonRepository repository;

  const NotificationSettingsSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      NotificationSettingsSaveParams params) async {
    return await repository.saveNotificationSettings(
        SessionNotificationSettingsModel(isOn: params.status));
  }
}

class NotificationSettingsSaveParams {
  bool status;

  NotificationSettingsSaveParams({required this.status});
}
