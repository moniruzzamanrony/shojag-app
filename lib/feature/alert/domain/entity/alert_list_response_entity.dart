import 'alert_entity.dart';

class AlertListResponseEntity {
  final List<AlertEntity> alerts;
  final int total;
  final int currentPage;
  final int lastPage;
  final int perPage;

  const AlertListResponseEntity({
    required this.alerts,
    required this.total,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
  });
}


