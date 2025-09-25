import 'package:app/core/utils/enums/sort_type.dart';
import 'package:hive_ce/hive.dart';

import 'hive_types.dart';

part 'session_list_sort_type_model.g.dart';

/// This class represents a model for storing the list sort type.
/// It has a field `type` of type `SortType`, which is used to store the type of the list sort type.
///
/// The `SessionListSortTypeModel` class is annotated with the `HiveType` annotation,
/// which specifies the type ID for the Hive adapter.
@HiveType(typeId: sessionListSortTypeId)
class SessionListSortTypeModel {
  @HiveField(0, defaultValue: SortType.distance)
  final SortType type;

  const SessionListSortTypeModel({required this.type});
}
