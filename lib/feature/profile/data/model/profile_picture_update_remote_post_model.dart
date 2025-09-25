import 'package:dio/dio.dart';

class ProfilePictureUpdateRemotePostModel {
  final int userId;
  final MultipartFile profilePic;

  const ProfilePictureUpdateRemotePostModel({
    required this.userId,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'profile_pic': profilePic,
    };
  }

  factory ProfilePictureUpdateRemotePostModel.fromMap(
      Map<String, dynamic> map) {
    return ProfilePictureUpdateRemotePostModel(
      userId: map['user_id'] as int,
      profilePic: map['profile_pic'] as MultipartFile,
    );
  }
}
