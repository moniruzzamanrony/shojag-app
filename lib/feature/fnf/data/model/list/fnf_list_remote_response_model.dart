class FnfListRemoteResponseModel {
  FnfListRemoteResponseModel({
    this.success,
    this.message,
    this.data,
  });

  FnfListRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<Data>? data;

  FnfListRemoteResponseModel copyWith({
    bool? success,
    String? message,
    List<Data>? data,
  }) =>
      FnfListRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
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
    this.userPhone,
    this.userName,
    this.image,
    this.type,
    this.status,
    this.premiumStatus,
    this.latitude,
    this.longitude,
    this.locationUpdateTime,
    this.selfShareStatus,
    this.selfTimeLimit,
    this.friendShareStatus,
    this.friendTimeLimit,
    this.locations,
    this.message,
    this.messageTime,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    userPhone = json['user_phone'];
    userName = json['user_name'];
    image = json['image'];
    type = json['type'];
    status = json['status'];
    premiumStatus = json['premium_status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationUpdateTime = json['location_update_time'];
    selfShareStatus = json['self_share_status'];
    selfTimeLimit = json['self_time_limit'];
    friendShareStatus = json['friend_share_status'];
    friendTimeLimit = json['friend_time_limit'];
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations?.add(Locations.fromJson(v));
      });
    }
    message = json['message'];
    messageTime = json['message_time'];
  }

  num? id;
  num? userId;
  String? userPhone;
  String? userName;
  String? image;
  String? type;
  num? status;
  bool? premiumStatus;
  num? latitude;
  num? longitude;
  String? locationUpdateTime;
  String? selfShareStatus;
  String? selfTimeLimit;
  String? friendShareStatus;
  String? friendTimeLimit;
  List<Locations>? locations;
  String? message;
  String? messageTime;

  Data copyWith({
    num? id,
    num? userId,
    String? userPhone,
    String? userName,
    String? image,
    String? type,
    bool? premiumStatus,
    num? status,
    num? latitude,
    num? longitude,
    String? locationUpdateTime,
    String? selfShareStatus,
    String? selfTimeLimit,
    String? friendShareStatus,
    String? friendTimeLimit,
    List<Locations>? locations,
    String? message,
    String? messageTime,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        userPhone: userPhone ?? this.userPhone,
        userName: userName ?? this.userName,
        image: image ?? this.image,
        type: type ?? this.type,
        status: status ?? this.status,
        premiumStatus: premiumStatus ?? this.premiumStatus,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        locationUpdateTime: locationUpdateTime ?? this.locationUpdateTime,
        selfShareStatus: selfShareStatus ?? this.selfShareStatus,
        selfTimeLimit: selfTimeLimit ?? this.selfTimeLimit,
        friendShareStatus: friendShareStatus ?? this.friendShareStatus,
        friendTimeLimit: friendTimeLimit ?? this.friendTimeLimit,
        locations: locations ?? this.locations,
        message: message ?? this.message,
        messageTime: messageTime ?? this.messageTime,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['user_phone'] = userPhone;
    map['user_name'] = userName;
    map['image'] = image;
    map['type'] = type;
    map['status'] = status;
    map['premium_status'] = premiumStatus;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['location_update_time'] = locationUpdateTime;
    map['self_share_status'] = selfShareStatus;
    map['self_time_limit'] = selfTimeLimit;
    map['friend_share_status'] = friendShareStatus;
    map['friend_time_limit'] = friendTimeLimit;
    if (locations != null) {
      map['locations'] = locations?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['message_time'] = messageTime;
    return map;
  }
}

class Locations {
  Locations({
    this.id,
    this.friendId,
    this.userId,
    this.latitude,
    this.longitude,
    this.label,
    this.createdAt,
    this.updatedAt,
  });

  Locations.fromJson(dynamic json) {
    id = json['id'];
    friendId = json['friend_id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    label = json['label'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  num? friendId;
  num? userId;
  num? latitude;
  num? longitude;
  String? label;
  String? createdAt;
  String? updatedAt;

  Locations copyWith({
    num? id,
    num? friendId,
    num? userId,
    num? latitude,
    num? longitude,
    String? label,
    String? createdAt,
    String? updatedAt,
  }) =>
      Locations(
        id: id ?? this.id,
        friendId: friendId ?? this.friendId,
        userId: userId ?? this.userId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        label: label ?? this.label,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['friend_id'] = friendId;
    map['user_id'] = userId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['label'] = label;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
