/// [LocationSharingTimeType] enum is used to represent the location sharing time type
/// limited - location sharing is limited to a specific time
/// unlimited - location sharing is unlimited
/// off - location sharing is off
enum LocationSharingTimeType {
  limited,
  unlimited,
  off;

  factory LocationSharingTimeType.fromString(String name) {
    return values.firstWhere((element) => element.name == name,
        orElse: () => off);
  }
}
