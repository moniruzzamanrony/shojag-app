import 'package:app/feature/fnf/domain/entity/search_fnf_result_entity.dart';
import 'package:app/feature/fnf/domain/usecase/send_fnf_request_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/enums/operation_state.dart';
import '../../../../../core/utils/resource/dependency_injection.dart';

final fnfRequestProvider =
    StateNotifierProvider.autoDispose<FnfRequestNotifier, FnfRequestState>(
        (ref) => FnfRequestNotifier());

class FnfRequestState {
  final OperationState requestState;
  final String? errorMessage;

  FnfRequestState({
    required this.requestState,
    this.errorMessage,
  });

  FnfRequestState copyWith({
    OperationState? requestState,
    SearchFnfResultEntity? searchResult,
    String? errorMessage,
  }) {
    return FnfRequestState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory FnfRequestState.initial() => FnfRequestState(
        requestState: OperationState.idle,
      );
}

class FnfRequestNotifier extends StateNotifier<FnfRequestState> {
  FnfRequestNotifier() : super(FnfRequestState.initial());

  Future<void> sendRequest({
    required String token,
    required int senderId,
    required int receiverId,
  }) async {
    state = FnfRequestState(requestState: OperationState.waiting);

    final param = SendFnfRequestParam(
      token: token,
      senderId: senderId,
      receiverId: receiverId,
    );
    final fnfSendRequestUseCase = getIt<SendFnfRequestUseCase>();
    final response = await fnfSendRequestUseCase(param);

    return response.fold(
      (l) {
        state = state.copyWith(requestState: OperationState.error);
      },
      (r) {
        state = state.copyWith(
          requestState: r ? OperationState.success : OperationState.done,
        );
      },
    );
  }
}
