import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/resource/dependency_injection.dart';
import '../../../domain/usecase/update_fnf_message_use_case.dart';

final fnfMessageProvider =
    AsyncNotifierProvider.autoDispose<FnfMessageNotifier, bool>(
        FnfMessageNotifier.new);

class FnfMessageNotifier extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> sendMessage(
      {required String token,
      required int userId,
      required int fnfId,
      required String message}) async {
    state = const AsyncLoading();

    final param = UpdateFnfMessageParam(
        token: token, fnfId: fnfId, userId: userId, message: message);
    final fnfSendMessageUseCase = getIt<UpdateFnfMessageUseCase>();
    final result = await fnfSendMessageUseCase(param);

    result.fold((l) {
      state = AsyncError(l.message, StackTrace.current);
    }, (r) {
      state = AsyncData(r);
    });
  }
}
