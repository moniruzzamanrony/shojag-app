import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:app/feature/fnf/domain/usecase/add_fnf_address_use_case.dart';
import 'package:app/feature/fnf/domain/usecase/delete_fnf_address_use_case.dart';
import 'package:app/feature/fnf/presentation/map/provider/fnf_map_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/resource/dependency_injection.dart';

final fnfMapViewAddressProvider = StateNotifierProvider.autoDispose<
    FnfMapViewAddressNotifier, FnfMapViewAddressState>((ref) {
  final model = ref.watch(fnfMapViewProvider).model;
  return FnfMapViewAddressNotifier(model.locations);
}, dependencies: [fnfMapViewProvider]);

class FnfMapViewAddressState {
  final List<FnfLocationsEntity> addressList;

  const FnfMapViewAddressState({required this.addressList});

  FnfMapViewAddressState copyWith({
    List<FnfLocationsEntity>? addressList,
  }) {
    return FnfMapViewAddressState(
      addressList: addressList ?? this.addressList,
    );
  }
}

class FnfMapViewAddressNotifier extends StateNotifier<FnfMapViewAddressState> {
  final List<FnfLocationsEntity> list;

  FnfMapViewAddressNotifier(this.list)
      : super(FnfMapViewAddressState(addressList: list));

  void setAddresses(List<FnfLocationsEntity> list) {
    state = state.copyWith(addressList: list);
  }

  Future<bool> addAddress(
      {required String token,
      required int fnfId,
      required int userId,
      required String label,
      required double latitude,
      required double longitude}) async {
    final param = AddFnfAddressParam(
        token: token,
        fnfId: fnfId,
        userId: userId,
        label: label,
        latitude: latitude,
        longitude: longitude);
    final addAddressUseCase = getIt<AddFnfAddressUseCase>();

    final response = await addAddressUseCase(param);
    return response.fold((l) {
      return Future.error(l.message);
    }, (r) => r);
  }

  Future<bool> deleteAddress({
    required String token,
    required int fnfLocationId,
  }) async {
    final deleteAddressUseCase = getIt<DeleteFnfAddressUseCase>();

    final param =
        DeleteFnfAddressParam(token: token, fnfLocationId: fnfLocationId);
    final response = await deleteAddressUseCase(param);
    return response.fold((l) {
      return Future.error(l.message);
    }, (r) => r);
  }
}
