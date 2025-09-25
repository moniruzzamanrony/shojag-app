class SearchFnfRemotePostModel {
  final String phoneNumber;

  const SearchFnfRemotePostModel({
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phoneNumber,
    };
  }

  factory SearchFnfRemotePostModel.fromMap(Map<String, dynamic> map) {
    return SearchFnfRemotePostModel(
      phoneNumber: map['phone'] as String,
    );
  }
}
