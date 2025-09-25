import 'package:app/core/config/provider/base_provider.dart';

import '../../../core/utils/enums/alert_type.dart';
import '../../../core/utils/resource/dependency_injection.dart';
import '../domain/entity/incident_type_view_model.dart';
import '../domain/usecase/incident_get_local_list_use_case.dart';

/// Provider for the incident list
/// get incident list
class IncidentProvider extends BaseProvider {
  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  final _getIncidentListUseCase = getIt<IncidentGetLocalListUseCase>();
  List<IncidentTypeViewModel> incidentTypeList = [];

  Future<void> getIncidentList({int? categoryId}) async {
    final param = IncidentGetLocalListParam(categoryId: categoryId);
    final response = await _getIncidentListUseCase(param);
    incidentTypeList = response.fold(
      (l) => <IncidentTypeViewModel>[],
      (r) => r
          .map(
            (e) => IncidentTypeViewModel(
                id: e.id ?? 0,
                titleEn: e.titleEn,
                titleBn: e.titleBn,
                tags: e.tags,
                type: AlertType.fromId(e.categoryId)),
          )
          .toList(),
    );
  }
}
