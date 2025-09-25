import 'package:app/feature/alert/domain/entity/alert_entity.dart';

import 'alert_response_entity.dart';

class AlertDetailsEntity {
  final AlertEntity alert;
  final List<AlertResponseEntity> responseList;

  const AlertDetailsEntity({
    required this.alert,
    required this.responseList,
  });
}
