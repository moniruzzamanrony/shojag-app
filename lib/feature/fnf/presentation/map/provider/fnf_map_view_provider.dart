import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/domain/usecase/location_share_request_use_case.dart';
import 'package:app/feature/fnf/presentation/map/provider/current_fnf_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../../core/utils/resource/dependency_injection.dart';
import '../../../domain/usecase/get_fnf_details_use_case.dart';

final fnfMapViewProvider =
    StateNotifierProvider.autoDispose<FnfMapViewNotifier, FnfMapViewState>(
        (ref) => FnfMapViewNotifier(ref.watch(currentFnfModelProvider)),
        dependencies: [currentFnfModelProvider]);

class FnfMapViewNotifier extends StateNotifier<FnfMapViewState> {
  FnfMapViewNotifier(FnfListEntity model)
      : super(FnfMapViewState(model: model));

  void setMapController(MapboxMap mapController) {
    state = state.copyWith(mapController: mapController);
  }

  void toggleViewState() {
    final newState = state.viewState == AddressViewState.view
        ? AddressViewState.add
        : AddressViewState.view;
    state = state.copyWith(viewState: newState);
  }

  Future<void> getUpdatedFnfDetails(String token) async {
    final param = GetFnfDetailsParam(token: token, fnfId: state.model.id);
    final getFnfDetailsUseCase = getIt<GetFnfDetailsUseCase>();
    final response = await getFnfDetailsUseCase(param);
    response.fold(
      (l) {},
      (r) {
        final updatedModel = state.model.copyWith(
          latitude: r.latitude,
          longitude: r.longitude,
          locationLastUpdateTime: r.locationLastUpdateTime,
          locations: r.locations,
          selfLocationSharingTimeType: r.selfLocationSharingTimeType,
          selfLocationPermissionExpireAt: r.selfLocationPermissionExpireAt,
          friendLocationSharingTimeType: r.friendLocationSharingTimeType,
          friendLocationPermissionExpireAt: r.friendLocationPermissionExpireAt,
          id: r.id,
          userId: r.userId,
          message: r.message,
        );
        state = state.copyWith(model: updatedModel);
      },
    );
  }

  Future<bool> locationShareRequest({required String token}) async {
    final param =
        LocationShareRequestParam(token: token, fnfId: state.model.id);
    final locationShareRequestUseCase = getIt<LocationShareRequestUseCase>();
    final response = await locationShareRequestUseCase(param);
    return response.fold((l) => false, (r) => true);
  }
}

class FnfMapViewState {
  final FnfListEntity model;
  final AddressViewState viewState;
  final MapboxMap? mapController;

  const FnfMapViewState({
    required this.model,
    this.viewState = AddressViewState.view,
    this.mapController,
  });

  FnfMapViewState copyWith({
    FnfListEntity? model,
    AddressViewState? viewState,
    MapboxMap? mapController,
  }) =>
      FnfMapViewState(
        model: model ?? this.model,
        viewState: viewState ?? this.viewState,
        mapController: mapController ?? this.mapController,
      );
}

enum AddressViewState { view, add }
