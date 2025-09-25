import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/enums/alert_status.dart';
import '../../../../../core/utils/enums/alert_type.dart';
import '../../../../../core/utils/helper/datetime_helper.dart';
import '../../../domain/entity/alert_entity.dart';

class AlertListRemoteResponseModel {
  AlertListRemoteResponseModel({
    this.success,
    this.message,
    this.data,
    this.pagination,
  });

  AlertListRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  AlertListRemoteResponseModel copyWith({
    bool? success,
    String? message,
    List<Data>? data,
    Pagination? pagination,
  }) =>
      AlertListRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}

class Pagination {
  Pagination({
    this.total,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
  }

  int? total;
  int? currentPage;
  int? lastPage;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  Pagination copyWith({
    int? total,
    int? currentPage,
    int? lastPage,
    int? perPage,
    String? nextPageUrl,
    String? prevPageUrl,
  }) =>
      Pagination(
        total: total ?? this.total,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        perPage: perPage ?? this.perPage,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    map['next_page_url'] = nextPageUrl;
    map['prev_page_url'] = prevPageUrl;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.userId,
    this.userName,
    this.userPhone,
    this.categoryIds,
    this.incidentTitle,
    this.description,
    this.latitude,
    this.longitude,
    this.distance,
    this.address,
    this.geoAddress,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    categoryIds = json['category_ids'];
    incidentTitle = json['incident_title'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    address = json['address'];
    geoAddress = json['geo_address'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  int? userId;
  String? userName;
  String? userPhone;
  String? categoryIds;
  String? incidentTitle;
  String? description;
  double? latitude;
  double? longitude;
  num? distance;
  String? address;
  String? geoAddress;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data copyWith({
    int? id,
    int? userId,
    String? userName,
    String? userPhone,
    String? categoryIds,
    String? incidentTitle,
    String? description,
    double? latitude,
    double? longitude,
    num? distance,
    String? address,
    String? geoAddress,
    String? image,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userPhone: userPhone ?? this.userPhone,
        categoryIds: categoryIds ?? this.categoryIds,
        incidentTitle: incidentTitle ?? this.incidentTitle,
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['user_phone'] = userPhone;
    map['category_ids'] = categoryIds;
    map['incident_title'] = incidentTitle;
    map['description'] = description;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['distance'] = distance;
    map['address'] = address;
    map['geo_address'] = geoAddress;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }


  AlertEntity toEntity() => AlertEntity(
        id: id ?? 0,
        userId: userId ?? 0,
        userName: userName ?? '',
        userPhone: userPhone ?? '',
        alertCategories: categoryIds
                ?.split(AppConstants.arraySplitter)
                .map(
                  (el) => AlertType.fromId(int.tryParse(el) ?? 0),
                )
                .where(
                  (t) => t != AlertType.none,
                )
                .toList() ??
            [],
        incidentTitle: incidentTitle ?? '',
        description: description,
        address: address,
        geoAddress: geoAddress,
        image: image,
        status: AlertStatus.fromId(status ?? 0),
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
        distance: distance?.toDouble() ?? 0,
        createdAt: getDateTimeFromString(date: createdAt),
        updatedAt: getDateTimeFromString(date: updatedAt),
      );
}
