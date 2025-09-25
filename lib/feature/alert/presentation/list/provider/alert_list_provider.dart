import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/alert/domain/entity/alert_entity.dart';
import 'package:app/feature/alert/domain/usecase/alert_get_active_list_remote_use_case.dart';
import 'package:app/feature/alert/presentation/list/provider/list_sort_type_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/enums/list_type.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecase/alert_get_closed_list_remote_use_case.dart';
import '../../../domain/usecase/alert_get_list_remote_param.dart';
import '../../../domain/usecase/alert_get_my_list_remote_use_case.dart';
import '../../../domain/usecase/alert_get_reponded_list_remote_use_case.dart';

class AlertListProvider extends BaseProvider {
  final BuildContext context;

  AlertListProvider(this.context);

  ListType listType = ListType.active;

  void updateListType(ListType type) {
    if (listType == type) return;

    listType = type;
    notify();
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    listType = ListType.active;
  }

  void updateAlertModel(AlertEntity updatedModel) {
    for (final type in ListType.values) {
      final state = _states[type];
      if (state == null) continue;

      final tempList = List<AlertEntity>.from(state.alerts);
      final index =
          tempList.indexWhere((element) => element.id == updatedModel.id);
      if (index != -1) {
        tempList[index] = updatedModel;
        state.alerts = tempList;
      }
    }
    notify();
  }

  final Map<ListType, AlertListState> _states = {
    ListType.active: AlertListState.initial(),
    ListType.closed: AlertListState.initial(),
    ListType.myAlerts: AlertListState.initial(),
    ListType.responded: AlertListState.initial(),
  };

  void deleteAlertIfExist(AlertEntity alert) {
    for (final type in ListType.values) {
      final state = _states[type];
      if (state == null) continue;

      final tempList = List<AlertEntity>.from(state.alerts);
      tempList.removeWhere((element) => element.id == alert.id);
      state.alerts = tempList;
    }
    notify();
  }

  // Public Getters
  List<AlertEntity> getAlertList(ListType type) => _states[type]?.alerts ?? [];

  bool isLoading(ListType type) => _states[type]?.isLoading ?? false;

  bool isFetching(ListType type) => _states[type]?.isFetching ?? false;

  // Internal Helper to get proper use case
  UseCase _getUseCase(ListType type) {
    switch (type) {
      case ListType.active:
        return getIt<AlertGetActiveListRemoteUseCase>();
      case ListType.closed:
        return getIt<AlertGetClosedListRemoteUseCase>();
      case ListType.myAlerts:
        return getIt<AlertGetMyListRemoteUseCase>();
      case ListType.responded:
        return getIt<AlertGetRespondedListRemoteUseCase>();
    }
  }

  Future<void> _populateAlertList({
    required String token,
    required int userId,
    required ListType type,
  }) async {
    final state = _states[type]!;
    state.page = 0;
    state.totalCount = 0;
    state.isLoading = true;
    notify();

    final sortBy = context.read<ListSortTypeProvider>().sortType;

    final result = await _getUseCase(type)(AlertGetListRemoteParam(
        token: token, userId: userId, page: 1, sortBy: sortBy));
    result.fold(
      (_) => state.alerts = [],
      (response) {
        state.alerts = response.alerts;
        state.page = response.currentPage;
        state.totalCount = response.total;
      },
    );

    state.isLoading = false;
    notify();
  }

  Future<void> fetchMoreAlerts({
    required String token,
    required int userId,
    required ListType type,
  }) async {
    final state = _states[type]!;

    if (state.alerts.length >= state.totalCount || state.isFetching) return;

    state.isFetching = true;
    notify();

    final sortBy = context.read<ListSortTypeProvider>().sortType;

    final nextPage = state.page + 1;
    final result = await _getUseCase(type)(AlertGetListRemoteParam(
        token: token, userId: userId, page: nextPage, sortBy: sortBy));
    result.fold(
      (_) {},
      (response) {
        state.alerts.addAll(response.alerts);
        state.page = response.currentPage;
        state.totalCount = response.total;
      },
    );

    state.isFetching = false;
    notify();
  }

  Future<void> populateAllAlertLists({
    required String token,
    required int userId,
    required bool loadMyAlerts,
  }) async {
    await Future.wait([
      _populateAlertList(token: token, userId: userId, type: ListType.active),
      _populateAlertList(token: token, userId: userId, type: ListType.closed),
      _populateAlertList(
          token: token, userId: userId, type: ListType.responded),
      if (loadMyAlerts)
        _populateAlertList(
            token: token, userId: userId, type: ListType.myAlerts),
    ]);
  }
}

class AlertListState {
  List<AlertEntity> alerts;
  int page;
  int totalCount;
  bool isLoading;
  bool isFetching;

  AlertListState.initial()
      : alerts = [],
        page = 0,
        totalCount = 0,
        isLoading = false,
        isFetching = false;
}
