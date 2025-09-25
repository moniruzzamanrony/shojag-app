import 'package:app/core/utils/enums/gender.dart';
import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/feature/premium/domain/entity/premium_entity.dart';

class UserInfoEntity {
  final int userId;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final bool isPhoneVerified;
  final bool isEmailVerified;

  final UserType userType;

  final Gender? gender;

  final DateTime? dob;
  final String? nid;
  final String? address;
  final String? photo;

  final String? policeId;
  final String? thana;

  final String? fireStation;
  final String? hospitalOrAgency;

  final String? apiToken;

  final num? areaLimit;

  final PremiumEntity premiumInfo;

  const UserInfoEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    required this.userType,
    this.gender,
    this.dob,
    this.nid,
    this.address,
    this.photo,
    this.policeId,
    this.thana,
    this.fireStation,
    this.areaLimit,
    this.hospitalOrAgency,
    this.apiToken,
    required this.premiumInfo,
  });
}
