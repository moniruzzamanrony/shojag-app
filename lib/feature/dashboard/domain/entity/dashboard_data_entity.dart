import 'package:app/feature/alert/domain/entity/alert_entity.dart';

class DashboardDataEntity{
  final List<AlertEntity> activeList;
  final List<AlertEntity> closeList;
  final List<AlertEntity> respondedList;
  final List<AlertEntity> myList;

  DashboardDataEntity({
    required this.activeList,
    required this.closeList,
    required this.respondedList,
    required this.myList,
  });
}