class SendRequestRemoteResponseModel {
  bool? success;
  String? message;

  SendRequestRemoteResponseModel({this.success, this.message});

  SendRequestRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }
}
