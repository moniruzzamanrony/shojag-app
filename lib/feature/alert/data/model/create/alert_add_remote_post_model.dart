import 'package:dio/dio.dart';

class AlertAddRemotePostModel {
  final int userId;
  final String categoryIds;
  final int? incidentId;
  final String? customIncident;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final String? geoAddress;
  final MultipartFile? image;

  AlertAddRemotePostModel({
    required this.userId,
    required this.categoryIds,
    this.incidentId,
    this.customIncident,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.geoAddress,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'category_ids': categoryIds,
      'incident_id': incidentId,
      'custom_incident': customIncident,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'geo_address': geoAddress,
      'image': image,
    };
  }

  factory AlertAddRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AlertAddRemotePostModel(
      userId: map['user_id'] as int,
      categoryIds: map['category_ids'] as String,
      incidentId: map['incident_id'] as int?,
      customIncident: map['custom_incident'] as String?,
      description: map['description'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      address: map['address'] as String,
      geoAddress: map['geo_address'] as String?,
      image: map['image'] as MultipartFile?,
    );
  }
}
