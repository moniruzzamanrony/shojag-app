import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/enums/list_type.dart';
import 'package:app/core/utils/enums/operation_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/alert_status.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../../alert/domain/entity/alert_entity.dart';
import '../../../alert/presentation/list/provider/list_sort_type_provider.dart';
import '../../../dashboard/domain/usecase/get_dashboard_data_use_case.dart';

class HomeProvider extends BaseProvider {
  List<AlertEntity> _activeAlerts = [];
  List<AlertEntity> _closedAlerts = [];
  List<AlertEntity> _respondedAlerts = [];
  List<AlertEntity> _myAlerts = [];

  OperationState operationState = OperationState.idle;

  Future<void> getDashboardData(
      {required String token, required int userId}) async {
    operationState = OperationState.waiting;
    notify();

    final sortBy = context.read<ListSortTypeProvider>().sortType.name;
    final getDashboardDataUseCase = getIt<GetDashboardDataUseCase>();

    final result = await getDashboardDataUseCase.call(
        GetDashboardDataParam(token: token, userId: userId, sortBy: sortBy));
    return result.fold((l) {
      operationState = OperationState.error;
      notify();
      return Future.error(l.message);
    }, (r) {
      _activeAlerts = r.activeList;
      _closedAlerts = r.closeList;
      _respondedAlerts = r.respondedList;
      _myAlerts = r.myList;
      operationState = OperationState.success;
      notify();
    });
  }

  AlertEntity? get myActiveAlert {
    return _myAlerts.firstWhereOrNull(
      (element) => element.status == AlertStatus.active,
    );
  }

  void updateAlertModel(AlertEntity updatedModel) {
    bool updated = false;

    void updateList(
        List<AlertEntity> list, void Function(List<AlertEntity>) setter) {
      final tempList = List<AlertEntity>.from(list);
      final index =
          tempList.indexWhere((element) => element.id == updatedModel.id);
      if (index != -1) {
        tempList[index] = updatedModel;
        setter(tempList);
        updated = true;
      }
    }

    updateList(_activeAlerts, (list) => _activeAlerts = list);
    updateList(_closedAlerts, (list) => _closedAlerts = list);
    updateList(_respondedAlerts, (list) => _respondedAlerts = list);
    updateList(_myAlerts, (list) => _myAlerts = list);

    if (updated) notify();
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  List<AlertEntity> getAlertListBasedOnType(ListType type) {
    switch (type) {
      case ListType.active:
        return _activeAlerts;
      case ListType.closed:
        return _closedAlerts;
      case ListType.responded:
        return _respondedAlerts;
      case ListType.myAlerts:
        return _myAlerts;
    }
  }

  final BuildContext context;

  HomeProvider(this.context);
}
