import 'package:app/feature/fnf/domain/entity/search_fnf_result_entity.dart';
import 'package:app/feature/fnf/domain/usecase/search_fnf_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/enums/operation_state.dart';
import '../../../../../core/utils/resource/dependency_injection.dart';

final fnfSearchProvider =
    StateNotifierProvider.autoDispose<FnfSearchNotifier, FnfSearchState>(
  (ref) => FnfSearchNotifier(),
);

class FnfSearchState {
  final OperationState searchState;
  final SearchFnfResultEntity? searchResult;
  final String? errorMessage;

  FnfSearchState({
    required this.searchState,
    this.searchResult,
    this.errorMessage,
  });

  FnfSearchState copyWith({
    OperationState? searchState,
    OperationState? requestState,
    SearchFnfResultEntity? searchResult,
    String? errorMessage,
  }) {
    return FnfSearchState(
      searchState: searchState ?? this.searchState,
      searchResult: searchResult ?? this.searchResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory FnfSearchState.initial() =>
      FnfSearchState(searchState: OperationState.idle);
}

class FnfSearchNotifier extends StateNotifier<FnfSearchState> {
  FnfSearchNotifier() : super(FnfSearchState.initial());

  Future<void> searchFnf({
    required String phoneNumber,
    required String token,
  }) async {
    state = FnfSearchState(searchState: OperationState.waiting);

    final fnfSearchUseCase = getIt<SearchFnfUseCase>();
    final param = SearchFnfParam(
      token: token,
      phoneNumber: phoneNumber,

    );

    final response = await fnfSearchUseCase(param);

    response.fold(
      (l) {
        state = state.copyWith(
            searchState: OperationState.error, errorMessage: l.message);
      },
      (r) {
        state = state.copyWith(
          searchState: OperationState.done,
          searchResult: SearchFnfResultEntity(
            userId: r.userId,
            userName: r.userName,
            userPhone: r.userPhone,
            userImage: r.userImage,
            fnfStatus: r.fnfStatus,
          ),
        );
      },
    );
  }
}
