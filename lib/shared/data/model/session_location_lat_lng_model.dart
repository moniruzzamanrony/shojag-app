import 'package:hive_ce/hive.dart';
import 'package:latlong2/latlong.dart';

import 'hive_types.dart';

part 'session_location_lat_lng_model.g.dart';

/// This class represents a model for storing the latitude and longitude of a location.
/// It has a field `latitude` of type `double`, which is the latitude of the location.
/// It has a field `longitude` of type `double`, which is the longitude of the location.
///
/// The `SessionLocationLatLngModel` class is annotated with the `HiveType` annotation,
/// which specifies the type ID for the Hive adapter.
@HiveType(typeId: sessionLocationLatLngTypeId)
class SessionLocationLatLngModel {
  @HiveField(0, defaultValue: 0)
  final double latitude;

  @HiveField(1, defaultValue: 0)
  final double longitude;

  const SessionLocationLatLngModel({
    required this.latitude,
    required this.longitude,
  });
  factory SessionLocationLatLngModel.fromLatLng(LatLng latLng) {
    return SessionLocationLatLngModel(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
    );
  }
}