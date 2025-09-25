import 'package:app/core/utils/extension/number_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/alert_status.dart';
import '../../../../core/utils/enums/alert_type.dart';
import '../../../../shared/domain/entity/distance_model.dart';

class AlertEntity extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String? userPhone;
  final List<AlertType> alertCategories;
  final String incidentTitle;
  final String? incidentCategoryName;
  final String? description;
  final double latitude;
  final double longitude;
  final double distance;
  final String? address;
  final String? geoAddress;
  final String? image;
  final AlertStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AlertEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.alertCategories,
    required this.incidentTitle,
    this.incidentCategoryName,
    this.description,
    required this.latitude,
    required this.longitude,
    required this.distance,
    this.address,
    this.geoAddress,
    this.image,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  DistanceEntity get toDistanceModel => distance.kmToDistanceModel;

  AlertEntity copyWith({
    int? id,
    int? userId,
    String? userName,
    String? userPhone,
    List<AlertType>? alertCategories,
    String? incidentTitle,
    String? incidentCategoryName,
    String? description,
    double? latitude,
    double? longitude,
    double? distance,
    String? address,
    String? geoAddress,
    String? image,
    String? videoId,
    AlertStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AlertEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhone: userPhone ?? this.userPhone,
      alertCategories: alertCategories ?? this.alertCategories,
      incidentTitle: incidentTitle ?? this.incidentTitle,
      incidentCategoryName: incidentCategoryName ?? this.incidentCategoryName,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distance: distance ?? this.distance,
      address: address ?? this.address,
      geoAddress: geoAddress ?? this.geoAddress,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userPhone,
        alertCategories,
        incidentTitle,
        description,
        latitude,
        longitude,
        distance,
        address,
        geoAddress,
        image,
        status,
        createdAt,
        updatedAt,
      ];

  factory AlertEntity.skeleton() => AlertEntity(
        id: 0,
        userId: 0,
        userName: 'User Name',
        userPhone: '',
        alertCategories: const [],
        incidentTitle: 'Incident Title',
        incidentCategoryName: 'Category Name',
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
        latitude: 0,
        longitude: 0,
        distance: 0,
        address: '',
        geoAddress: '',
        image: '',
        status: AlertStatus.none,
        createdAt: DateTime(1970),
      );
}
