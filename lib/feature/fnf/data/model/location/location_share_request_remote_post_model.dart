class LocationShareRequestRemotePostModel {
  final int fnfId;

  const LocationShareRequestRemotePostModel({required this.fnfId});

  Map<String, dynamic> toMap() {
    return {'friend_id': fnfId};
  }

  factory LocationShareRequestRemotePostModel.fromMap(
      Map<String, dynamic> map) {
    return LocationShareRequestRemotePostModel(fnfId: map['friend_id'] as int);
  }
}
