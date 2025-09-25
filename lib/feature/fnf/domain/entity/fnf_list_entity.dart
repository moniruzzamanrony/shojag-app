import 'package:app/core/utils/enums/fnf_status.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

import '../../../../core/utils/enums/location_sharing_time_type.dart';

class FnfListEntity extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String userPhone;
  final String? image;
  final FnfStatus status;
  final bool premiumStatus;
  final String _type;
  final double? latitude;
  final double? longitude;
  final DateTime? locationLastUpdateTime;
  final LocationSharingTimeType selfLocationSharingTimeType;
  final DateTime? selfLocationPermissionExpireAt;
  final LocationSharingTimeType friendLocationSharingTimeType;
  final DateTime? friendLocationPermissionExpireAt;
  final List<FnfLocationsEntity> locations;
  final FnfMessageEntity? message;

  const FnfListEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.image,
    required this.status,
    required String type,
    required this.premiumStatus,
    required this.latitude,
    required this.longitude,
    required this.selfLocationSharingTimeType,
    required this.selfLocationPermissionExpireAt,
    required this.friendLocationSharingTimeType,
    required this.friendLocationPermissionExpireAt,
    required this.locationLastUpdateTime,
    required this.locations,
    this.message,
  }) : _type = type;

  bool get isPending => status == FnfStatus.pending;

  bool get isAccepted => status == FnfStatus.accepted;

  bool get isSender => _type == 'sender';

  bool get isReceiver => _type == 'receiver';

  LatLng? get baseLocation => (latitude != null && longitude != null)
      ? LatLng(latitude!, longitude!)
      : null;

  mapbox.Point? get baseLocationPoint {
    if (latitude == null || longitude == null) {
      return null;
    }
    return mapbox.Point(coordinates: mapbox.Position(longitude!, latitude!));
  }

  bool get isSelfSharedIsEnabled {
    if (selfLocationSharingTimeType == LocationSharingTimeType.unlimited) {
      return true;
    } else if (selfLocationSharingTimeType == LocationSharingTimeType.limited) {
      if (selfLocationPermissionExpireAt != null) {
        return DateTime.now().isBefore(selfLocationPermissionExpireAt!);
      }
    }
    return false;
  }

  bool get isFriendSharedIsEnabled {
    if (friendLocationSharingTimeType == LocationSharingTimeType.unlimited) {
      return true;
    } else if (friendLocationSharingTimeType ==
        LocationSharingTimeType.limited) {
      if (friendLocationPermissionExpireAt != null) {
        return DateTime.now().isBefore(friendLocationPermissionExpireAt!);
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userPhone,
        image,
        status,
        _type,
        latitude,
        longitude,
        selfLocationSharingTimeType,
        selfLocationPermissionExpireAt,
        locationLastUpdateTime,
        locations,
        message,
      ];

  factory FnfListEntity.skeleton() => FnfListEntity(
        id: 0,
        userId: 0,
        userName: 'Test User',
        userPhone: '00000000000',
        image: '',
        status: FnfStatus.accepted,
        type: '',
        premiumStatus: false,
        latitude: null,
        longitude: null,
        selfLocationSharingTimeType: LocationSharingTimeType.off,
        selfLocationPermissionExpireAt: null,
        friendLocationSharingTimeType: LocationSharingTimeType.off,
        friendLocationPermissionExpireAt: null,
        locationLastUpdateTime: DateTime(1970),
        locations: const [],
      );

  FnfListEntity copyWith({
    int? id,
    int? userId,
    String? userName,
    String? userPhone,
    String? image,
    FnfStatus? status,
    bool? premiumStatus,
    String? type,
    double? latitude,
    double? longitude,
    LocationSharingTimeType? selfLocationSharingTimeType,
    DateTime? selfLocationPermissionExpireAt,
    LocationSharingTimeType? friendLocationSharingTimeType,
    DateTime? friendLocationPermissionExpireAt,
    DateTime? locationLastUpdateTime,
    List<FnfLocationsEntity>? locations,
    FnfMessageEntity? message,
  }) {
    return FnfListEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhone: userPhone ?? this.userPhone,
      image: image ?? this.image,
      status: status ?? this.status,
      premiumStatus: premiumStatus ?? this.premiumStatus,
      type: type ?? _type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      selfLocationSharingTimeType:
          selfLocationSharingTimeType ?? this.selfLocationSharingTimeType,
      selfLocationPermissionExpireAt:
          selfLocationPermissionExpireAt ?? this.selfLocationPermissionExpireAt,
      friendLocationSharingTimeType:
          friendLocationSharingTimeType ?? this.friendLocationSharingTimeType,
      friendLocationPermissionExpireAt: friendLocationPermissionExpireAt ??
          this.friendLocationPermissionExpireAt,
      locationLastUpdateTime:
          locationLastUpdateTime ?? this.locationLastUpdateTime,
      locations: locations ?? this.locations,
      message: message ?? this.message,
    );
  }
}

class AcceptedFnfDetailsEntity extends Equatable {
  final int id;
  final int userId;
  final double latitude;
  final double longitude;
  final LocationSharingTimeType selfLocationSharingTimeType;
  final DateTime? selfLocationPermissionExpireAt;
  final LocationSharingTimeType friendLocationSharingTimeType;
  final DateTime? friendLocationPermissionExpireAt;
  final DateTime locationLastUpdateTime;

  @override
  List<Object?> get props => [
        id,
        userId,
        latitude,
        longitude,
        selfLocationSharingTimeType,
        selfLocationPermissionExpireAt,
        friendLocationSharingTimeType,
        friendLocationPermissionExpireAt,
        locationLastUpdateTime,
      ];

  const AcceptedFnfDetailsEntity({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.selfLocationSharingTimeType,
    this.selfLocationPermissionExpireAt,
    required this.friendLocationSharingTimeType,
    this.friendLocationPermissionExpireAt,
    required this.locationLastUpdateTime,
  });
}

class FnfMessageEntity extends Equatable {
  final String? message;
  final DateTime? time;

  const FnfMessageEntity({this.message, this.time});

  @override
  List<Object?> get props => [message, time];
}

// Location Entity for CurrentFnF
class FnfLocationsEntity extends Equatable {
  final int id;
  final int fnfId;
  final String label;
  final double latitude;
  final double longitude;

  const FnfLocationsEntity(
      {required this.id,
      required this.fnfId,
      required this.label,
      required this.latitude,
      required this.longitude});

  @override
  List<Object?> get props => [id, fnfId, label, latitude, longitude];
}
