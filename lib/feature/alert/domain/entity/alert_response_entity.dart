import 'package:app/core/utils/enums/user_type.dart';
import 'package:equatable/equatable.dart';

class AlertResponseEntity extends Equatable{
  final int userId;
  final String name;
  final UserType userType;
  final double latitude;
  final double longitude;
  final DateTime? locationUpdatedAt;
  final String? message;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AlertResponseEntity({
    required this.userId,
    required this.name,
    required this.userType,
    required this.latitude,
    required this.longitude,
    this.locationUpdatedAt,
    this.message,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    userId,
    name,
    userType,
    latitude,
    longitude,
    locationUpdatedAt,
    message,
    image,
    createdAt,
    updatedAt
  ];
}
