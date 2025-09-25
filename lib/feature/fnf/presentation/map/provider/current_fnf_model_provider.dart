import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../fnf/domain/entity/fnf_list_entity.dart';

// final currentFnfModelProvider = Provider<FnfListEntity>(
//   (ref) {
//     throw UnimplementedError('You must override this provider');
//   },
// );

final currentFnfModelProvider =
    StateProvider<FnfListEntity>((ref) => FnfListEntity.skeleton());
