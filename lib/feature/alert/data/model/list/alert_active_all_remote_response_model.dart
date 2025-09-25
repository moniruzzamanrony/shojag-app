class AlertActiveAllRemoteResponseModel {
  AlertActiveAllRemoteResponseModel({
    this.success,
    this.message,
    this.userLatitude,
    this.userLongitude,
    this.data,
  });

  AlertActiveAllRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  num? userLatitude;
  num? userLongitude;
  List<Data>? data;

  AlertActiveAllRemoteResponseModel copyWith({
    bool? success,
    String? message,
    num? userLatitude,
    num? userLongitude,
    List<Data>? data,
  }) =>
      AlertActiveAllRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        userLatitude: userLatitude ?? this.userLatitude,
        userLongitude: userLongitude ?? this.userLongitude,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['user_latitude'] = userLatitude;
    map['user_longitude'] = userLongitude;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
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
    this.incidentCategoryName,
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
    incidentCategoryName = json['incident_category_name'];
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

  num? id;
  num? userId;
  String? userName;
  String? userPhone;
  String? categoryIds;
  String? incidentTitle;
  String? incidentCategoryName;
  String? description;
  num? latitude;
  num? longitude;
  num? distance;
  String? address;
  String? geoAddress;
  String? image;
  num? status;
  String? createdAt;
  String? updatedAt;

  Data copyWith({
    num? id,
    num? userId,
    String? userName,
    String? userPhone,
    String? categoryIds,
    String? incidentTitle,
    String? incidentCategoryName,
    String? description,
    num? latitude,
    num? longitude,
    num? distance,
    String? address,
    String? geoAddress,
    String? image,
    num? status,
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['user_phone'] = userPhone;
    map['category_ids'] = categoryIds;
    map['incident_title'] = incidentTitle;
    map['incident_category_name'] = incidentCategoryName;
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
}
