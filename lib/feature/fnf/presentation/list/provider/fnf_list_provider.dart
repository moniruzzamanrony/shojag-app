import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/fnf/domain/entity/fnf_list_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecase/get_fnf_list_use_case.dart';

final fnfListProvider =
    StateNotifierProvider<FnfListNotifier, FnfListState>((ref) {
  return FnfListNotifier(FnfListState.initial());
});

class FnfListNotifier extends StateNotifier<FnfListState> {
  FnfListNotifier(super.state);

  Future<void> loadList({required String token, required int userId}) async {
    state = const FnfListState(isLoading: true);
    final param = GetFnfListParam(token: token, userId: userId);
    final getFnfListUseCase = getIt<GetFnfListUseCase>();
    final response = await getFnfListUseCase(param);
    response.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.message);
      },
      (r) {
        state = state.copyWith(isLoading: false, list: r);
      },
    );
  }

  void replaceItem(FnfListEntity item) {
    state = state.copyWith(
        list: state.list.map((e) => e.id == item.id ? item : e).toList());
  }
}

class FnfListState {
  final List<FnfListEntity> list;
  final bool isLoading;
  final String? error;

  const FnfListState(
      {this.list = const [], this.isLoading = false, this.error});

  factory FnfListState.initial() {
    return const FnfListState();
  }

  FnfListEntity? getListItemById(int id) {
    try {
      return list.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  FnfListState copyWith({
    List<FnfListEntity>? list,
    bool? isLoading,
    String? error,
  }) {
    return FnfListState(
      list: list ?? this.list,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
