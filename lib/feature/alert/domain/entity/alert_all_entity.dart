import 'package:app/feature/alert/domain/entity/alert_entity.dart';

class AlertAllEntity {
  final double latitude;
  final double longitude;
  final List<AlertEntity> alerts;

  const AlertAllEntity({
    required this.latitude,
    required this.longitude,
    required this.alerts,
  });
}
