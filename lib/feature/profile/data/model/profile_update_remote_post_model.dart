class ProfileUpdateRemotePostModel {
  int userId;
  String firstName;
  String lastName;
  String? email;
  String? gender;
  String? dob;
  String? nid;
  String? address;
  int? thanaId;

  ProfileUpdateRemotePostModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.nid,
    required this.address,
    required this.thanaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'gender': gender,
      'dob': dob,
      'nid': nid,
      'address': address,
      'thana_id': thanaId,
    };
  }

  factory ProfileUpdateRemotePostModel.fromMap(Map<String, dynamic> map) {
    return ProfileUpdateRemotePostModel(
      userId: map['user_id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String?,
      gender: map['gender'] as String?,
      dob: map['dob'] as String?,
      nid: map['nid'] as String?,
      address: map['address'] as String?,
      thanaId: map['thana_id'] as int?,
    );
  }
}
