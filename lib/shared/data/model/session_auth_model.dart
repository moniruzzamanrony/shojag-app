import 'package:hive_ce/hive.dart';

import 'hive_types.dart';

part 'session_auth_model.g.dart';

/// This class represents a model for storing user authentication information.
/// It has a field `loginStatus` of type `bool` which is used to indicate whether the user is logged in or not.
/// It has a field `userId` of type `int` which is used to store the user id.
/// It has a field `userType` of type `int` which is used to store the user type.
/// It has a field `apiToken` of type `String` which is used to store the API token.
/// It has a field `firstName` of type `String` which is used to store the first name of the user.
/// It has a field `lastName` of type `String` which is used to store the last name of the user.
/// It has a field `email` of type `String` which is used to store the email of the user.
/// It has a field `phone` of type `String` which is used to store the phone number of the user.
/// It has a field `gender` of type `String` which is used to store the gender of the user.
/// It has a field `dob` of type `String` which is used to store the date of birth of the user.
/// It has a field `nid` of type `String` which is used to store the NID of the user.
/// It has a field `address` of type `String` which is used to store the address of the user.
/// It has a field `photo` of type `String` which is used to store the photo of the user.
/// It has a field `policeId` of type `String` which is used to store the police id of the user.
/// It has a field `thana` of type `String` which is used to store the thana of the user.
/// It has a field `fireStation` of type `String` which is used to store the fire station of the user.
/// It has a field `hospitalAgency` of type `String` which is used to store the hospital agency of the user.
/// It has a field `isEmailVerified` of type `bool` which is used to indicate whether the email is verified or not.
/// It has a field `isPhoneVerified` of type `bool` which is used to indicate whether the phone is verified or not.
@HiveType(typeId: sessionAuthModelTypeId)
class SessionAuthModel {
  @HiveField(0, defaultValue: false)
  final bool loginStatus;

  @HiveField(1, defaultValue: 0)
  final int userId;

  @HiveField(2, defaultValue: 0)
  final int userType;

  @HiveField(3, defaultValue: '')
  final String apiToken;

  @HiveField(4, defaultValue: '')
  final String firstName;

  @HiveField(5, defaultValue: '')
  final String lastName;

  @HiveField(6, defaultValue: null)
  final String? email;

  @HiveField(7, defaultValue: '')
  final String phone;

  @HiveField(8, defaultValue: null)
  final String? gender;

  @HiveField(9, defaultValue: null)
  final String? dob;

  @HiveField(10, defaultValue: null)
  final String? nid;

  @HiveField(11, defaultValue: null)
  final String? address;

  @HiveField(12, defaultValue: null)
  final String? photo;

  @HiveField(13, defaultValue: null)
  final String? policeId;

  @HiveField(14, defaultValue: null)
  final String? thana;

  @HiveField(15, defaultValue: null)
  final String? fireStation;

  @HiveField(16, defaultValue: null)
  final String? hospitalOrAgency;

  @HiveField(17, defaultValue: false)
  final bool isEmailVerified;

  @HiveField(18, defaultValue: false)
  final bool isPhoneVerified;

  const SessionAuthModel({
    required this.loginStatus,
    required this.userId,
    required this.userType,
    required this.apiToken,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.email,
    this.gender,
    this.dob,
    this.nid,
    this.address,
    this.photo,
    this.policeId,
    this.thana,
    this.fireStation,
    this.hospitalOrAgency,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });
}
