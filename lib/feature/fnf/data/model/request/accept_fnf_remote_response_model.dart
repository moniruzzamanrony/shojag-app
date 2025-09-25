class AcceptFnfRemoteResponseModel {
  AcceptFnfRemoteResponseModel({
    this.success,
    this.id,
    this.status,
    this.message,
  });

  AcceptFnfRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    id = json['id'];
    status = json['status'];
    message = json['message'];
  }

  bool? success;
  num? id;
  num? status;
  String? message;

  AcceptFnfRemoteResponseModel copyWith({
    bool? success,
    num? id,
    num? status,
    String? message,
  }) =>
      AcceptFnfRemoteResponseModel(
        success: success ?? this.success,
        id: id ?? this.id,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['id'] = id;
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
