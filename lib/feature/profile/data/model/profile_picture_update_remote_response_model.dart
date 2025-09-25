class ProfilePictureUpdateRemoteResponseModel {
  ProfilePictureUpdateRemoteResponseModel({
      this.success, 
      this.message, 
      this.profilePic,});

  ProfilePictureUpdateRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    profilePic = json['profile_pic'];
  }
  bool? success;
  String? message;
  String? profilePic;
ProfilePictureUpdateRemoteResponseModel copyWith({  bool? success,
  String? message,
  String? profilePic,
}) => ProfilePictureUpdateRemoteResponseModel(  success: success ?? this.success,
  message: message ?? this.message,
  profilePic: profilePic ?? this.profilePic,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['profile_pic'] = profilePic;
    return map;
  }

}