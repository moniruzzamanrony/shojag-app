class AlertDetailsRemoteResponseModel {
  AlertDetailsRemoteResponseModel({
    this.success,
    this.message,
    this.alert,
    this.responseList,
  });

  AlertDetailsRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    alert = json['alert'] != null ? Alert.fromJson(json['alert']) : null;
    if (json['response_list'] != null) {
      responseList = [];
      json['response_list'].forEach((v) {
        responseList?.add(ResponseList.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  Alert? alert;
  List<ResponseList>? responseList;

  AlertDetailsRemoteResponseModel copyWith({
    bool? success,
    String? message,
    Alert? alert,
    List<ResponseList>? responseList,
  }) =>
      AlertDetailsRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        alert: alert ?? this.alert,
        responseList: responseList ?? this.responseList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (alert != null) {
      map['alert'] = alert?.toJson();
    }
    if (responseList != null) {
      map['response_list'] = responseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ResponseList {
  ResponseList({
    this.responderId,
    this.responderType,
    this.userName,
    this.responderLat,
    this.responderLong,
    this.locationUpdatedAt,
    this.profileImage,
    this.responseMessage,
    this.createdAt,
    this.updatedAt,
  });

  ResponseList.fromJson(dynamic json) {
    responderId = json['responder_id'];
    responderType = json['responder_type'];
    userName = json['user_name'];
    responderLat = json['responder_lat'];
    responderLong = json['responder_long'];
    locationUpdatedAt = json['location_updated_at'];
    profileImage = json['profile_image'];
    responseMessage = json['response_message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? responderId;
  num? responderType;
  String? userName;
  num? responderLat;
  num? responderLong;
  String? locationUpdatedAt;
  String? profileImage;
  String? responseMessage;
  String? createdAt;
  String? updatedAt;

  ResponseList copyWith({
    num? responderId,
    num? responderType,
    String? userName,
    num? responderLat,
    num? responderLong,
    String? locationUpdatedAt,
    String? profileImage,
    String? responseMessage,
    String? createdAt,
    String? updatedAt,
  }) =>
      ResponseList(
        responderId: responderId ?? this.responderId,
        responderType: responderType ?? this.responderType,
        userName: userName ?? this.userName,
        responderLat: responderLat ?? this.responderLat,
        responderLong: responderLong ?? this.responderLong,
        locationUpdatedAt: locationUpdatedAt ?? this.locationUpdatedAt,
        profileImage: profileImage ?? this.profileImage,
        responseMessage: responseMessage ?? this.responseMessage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responder_id'] = responderId;
    map['responder_type'] = responderType;
    map['user_name'] = userName;
    map['responder_lat'] = responderLat;
    map['responder_long'] = responderLong;
    map['location_updated_at'] = locationUpdatedAt;
    map['profile_image'] = profileImage;
    map['response_message'] = responseMessage;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Alert {
  Alert({
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
  });

  Alert.fromJson(dynamic json) {
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
  }

  num? id;
  num? userId;
  String? userName;
  String? userPhone;
  String? categoryIds;
  String? incidentTitle;
  String? description;
  num? latitude;
  num? longitude;
  num? distance;
  String? address;
  String? geoAddress;
  String? image;
  num? status;
  String? createdAt;

  Alert copyWith({
    num? id,
    num? userId,
    String? userName,
    String? userPhone,
    String? categoryIds,
    String? incidentTitle,
    String? description,
    num? latitude,
    num? longitude,
    num? distance,
    String? address,
    String? geoAddress,
    String? image,
    num? status,
    String? createdAt,
  }) =>
      Alert(
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
    return map;
  }
}
