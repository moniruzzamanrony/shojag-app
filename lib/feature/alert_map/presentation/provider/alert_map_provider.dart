import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/alert/domain/usecase/alert_get_active_all_remote_use_case.dart';
import 'package:app/feature/alert_map/presentation/view_model/category_set_view_model.dart';
import 'package:latlong2/latlong.dart';

import '../../../alert/domain/entity/alert_entity.dart';

class AlertMapProvider extends BaseProvider {
  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  late LatLng center;
  List<AlertEntity> _allActiveAlerts = [];
  Map<String, CategorySetViewModel> categories = {};
  String? selectedCategory;

  bool isLoading = false;

  Future<void> populateAllActiveAlertList(
      {required String token, required int userId}) async {
    final alertAllUseCase = getIt<AlertGetActiveAllRemoteUseCase>();

    final param = AlertGetActiveAllRemoteParam(token: token, userId: userId);
    isLoading = true;
    notify();
    final response = await alertAllUseCase(param);
    isLoading = false;
    notify();
    response.fold((l) {}, (r) {
      final alerts = r.alerts.map((e) => e).toList();
      selectedCategory = null;
      center = LatLng(r.latitude, r.longitude);
      _allActiveAlerts = alerts;
      _populateCategories(alerts);
    });
  }

  void _populateCategories(List<AlertEntity> alerts) {
    categories = {};

    if (alerts.isEmpty) {
      return;
    }
    // populate alerts
    for (final alert in alerts) {
      final title = alert.incidentCategoryName ?? '';
      categories.update(
          title, (existing) => existing.copyWith(count: existing.count + 1),
          ifAbsent: () => CategorySetViewModel(name: title, count: 1));
    }

    // sort entries
    final sortedEntries = categories.entries.toList()
      ..sort((a, b) => b.value.count.compareTo(a.value.count));

    // populate sorted entries to categories
    categories = {for (final entry in sortedEntries) entry.key: entry.value};
  }

  List<AlertEntity> get alertsByCategories {
    if (selectedCategory == null) {
      return _allActiveAlerts;
    }

    return _allActiveAlerts
        .where((t) => t.incidentCategoryName == selectedCategory)
        .toList();
  }

  AlertMapProvider(LatLng lastLatLng) {
    center = lastLatLng;
    _allActiveAlerts = [];
    categories = {};
    selectedCategory = null;
  }
}
