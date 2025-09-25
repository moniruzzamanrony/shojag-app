class FnfLocationDeleteRemotePostModel {
  final int fnfLocationId;

  const FnfLocationDeleteRemotePostModel({required this.fnfLocationId});

  factory FnfLocationDeleteRemotePostModel.fromMap(Map<String, dynamic> json) {
    return FnfLocationDeleteRemotePostModel(fnfLocationId: json['fnf_location_id']);
  }

  Map<String, dynamic> toMap() => {'friend_location_id': fnfLocationId};
}
