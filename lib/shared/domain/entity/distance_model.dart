/// [DistanceEntity] contains distance and unit
class DistanceEntity {
  final num distance;
  final DistanceUnit unit;

  const DistanceEntity({
    required this.distance,
    required this.unit,
  });
}

/// [DistanceUnit] can be either meter or kilometer
enum DistanceUnit {
  meter,
  km;
}
