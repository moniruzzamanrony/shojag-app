class AreaLimitRemotePostModel {
  int userId;
  num areaLimit;

  AreaLimitRemotePostModel({
    required this.userId,
    required this.areaLimit,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'area_limit': areaLimit,
    };
  }

  factory AreaLimitRemotePostModel.fromMap(Map<String, dynamic> map) {
    return AreaLimitRemotePostModel(
      userId: map['user_id'] as int,
      areaLimit: map['area_limit'] as num,
    );
  }
}
