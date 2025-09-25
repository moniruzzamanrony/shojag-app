import 'package:app/feature/fnf/domain/usecase/accept_request_use_case.dart';
import 'package:app/feature/fnf/domain/usecase/delete_fnf_use_case.dart';
import 'package:app/feature/fnf/domain/usecase/location_share_limit_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/resource/dependency_injection.dart';

final fnfListActionProvider =
    StateNotifierProvider<FnfActionNotifier, AsyncValue<void>>(
  (ref) => FnfActionNotifier(),
);

class FnfActionNotifier extends StateNotifier<AsyncValue<void>> {
  FnfActionNotifier() : super(const AsyncData(null));

  Future<bool> acceptRequest(
      {required String token, required int fnfId}) async {
    state = const AsyncLoading();

    final param = AcceptRequestParam(token: token, fnfId: fnfId);
    final fnfAcceptRequestUseCase = getIt<AcceptRequestUseCase>();
    final response = await fnfAcceptRequestUseCase(param);

    return response.fold((l) {
      state = AsyncError(l.message, StackTrace.current);
      return false;
    }, (r) {
      state = const AsyncData(null);
      return true;
    });
  }

  Future<bool> deleteFnf(
      {required String token, required int fnfId, required int userId}) async {
    state = const AsyncLoading();

    final param = DeleteFnfParam(token: token, fnfId: fnfId, userId: userId);
    final fnfDeleteUseCase = getIt<DeleteFnfUseCase>();
    final response = await fnfDeleteUseCase(param);

    return response.fold((l) {
      state = AsyncError(l.message, StackTrace.current);
      return false;
    }, (r) {
      state = const AsyncData(null);
      return true;
    });
  }

  Future<bool> shareLocationStatus(
      {required String token,
      required int fnfId,
      required String status,
      String? timeLimit}) async {
    state = const AsyncLoading();
    final param = LocationShareLimitParam(
        token: token, fnfId: fnfId, timeLimit: timeLimit, shareStatus: status);
    final fnfLocationShareLimitUseCase = getIt<LocationShareLimitUseCase>();
    final response = await fnfLocationShareLimitUseCase(param);

    return response.fold((l) {
      state = AsyncError(l.message, StackTrace.current);
      return false;
    }, (r) {
      state = const AsyncData(null);
      return true;
    });
  }
}
