import 'package:hive_ce/hive.dart';

import 'hive_types.dart';

part 'session_area_radius_model.g.dart';
/// This class represents a model for storing the radius of an area.
/// It has a field `radius` of type `num`, which is the radius in meters.
///
/// The `SessionAreaRadiusModel` class is annotated with the `HiveType` annotation,
/// which specifies the type ID for the Hive adapter.
@HiveType(typeId: sessionAreaRadiusTypeId)
class SessionAreaRadiusModel {
  @HiveField(0, defaultValue: 0)
  final num radius;

  const SessionAreaRadiusModel({required this.radius});
}
