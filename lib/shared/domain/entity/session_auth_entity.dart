import '../../../../core/utils/enums/gender.dart';
import '../../../../core/utils/enums/user_type.dart';

/// This class is used to store the session information,
/// typically used to check if the user is logged in and
/// retrieve the user if any
class SessionAuthEntity {
  final bool isLoggedIn;
  final User user;

  const SessionAuthEntity({
    required this.isLoggedIn,
    required this.user,
  });

  SessionAuthEntity copyWith({
    bool? isLoggedIn,
    User? user,
  }) {
    return SessionAuthEntity(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
    );
  }
}

/// Base [User] class
///
/// Extends by [UserCitizen]
/// Extends by [UserPolice]
/// Extends by [UserAmbulance]
/// Extends by [UserFireStation]
/// Extends by [UserNone]
abstract class User {
  final int userId;
  final String firstName;
  final String lastName;
  final String? email;
  final String phone;
  final bool isPhoneVerified;
  final bool isEmailVerified;
  final UserType userType;
  final String apiToken;
  final String? photo;

  const User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    required this.userType,
    required this.apiToken,
    required this.photo,
  });

  String get name => '$firstName $lastName';

  User copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    UserType? userType,
    String? apiToken,
    String? photo,
  });
}

/// [UserCitizen] class extends [User]
/// ie:
/// ```
/// final user = UserCitizen(
///   userId: 1,
///   email: 'email',
///   firstName: 'firstName',
///   lastName: 'lastName',
///   phone: 'phone',
///   isPhoneVerified: true,
///   isEmailVerified: true,
///   userType: UserType.citizen,
///   apiToken: 'apiToken',
///   photo: 'photo',
///   gender: Gender.male,
///   dob: DateTime.now(),
///   nid: 'nid',
///   address: 'address',
/// );
/// ```
class UserCitizen extends User {
  final Gender gender;
  final DateTime? dob;
  final String? nid;
  final String? address;

  const UserCitizen(
      {required this.gender,
      this.dob,
      this.nid,
      this.address,
      super.email,
      required super.userId,
      required super.firstName,
      required super.lastName,
      required super.isPhoneVerified,
      required super.isEmailVerified,
      required super.userType,
      required super.apiToken,
      required super.photo,
      required super.phone});

  @override
  UserCitizen copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    UserType? userType,
    String? apiToken,
    String? photo,
    Gender? gender,
    DateTime? dob,
    String? nid,
    String? address,
  }) {
    return UserCitizen(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      userType: userType ?? this.userType,
      apiToken: apiToken ?? this.apiToken,
      photo: photo ?? this.photo,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      nid: nid ?? this.nid,
      address: address ?? this.address,
    );
  }
}


/// [UserFireService] class extends [User]
///  ie:
///  ```
///  final user = UserFireService(
///  userId: 1,
///  email: 'email',
///  fireStation: 'fireStation',
///  firstName: 'firstName',
///  lastName: 'lastName',
///  phone: 'phone',
///  isPhoneVerified: true,
///  isEmailVerified: true,
///  userType: UserType.fireService,
///  apiToken: 'apiToken',
///  photo: 'photo',
///  fireStation: 'fireStation',
/// );
/// ```
class UserFireService extends User {
  final String fireStation;

  const UserFireService(
      {required super.userId,
      super.email,
      required this.fireStation,
      required super.firstName,
      required super.lastName,
      required super.phone,
      required super.isPhoneVerified,
      required super.isEmailVerified,
      required super.userType,
      required super.apiToken,
      required super.photo});

  @override
  UserFireService copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    UserType? userType,
    String? apiToken,
    String? photo,
    String? fireStation,
  }) {
    return UserFireService(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      userType: userType ?? this.userType,
      apiToken: apiToken ?? this.apiToken,
      photo: photo ?? this.photo,
      fireStation: fireStation ?? this.fireStation,
    );
  }
}

/// [UserPolice] class extends [User]
///  ie:
///  ```
///  final user = UserPolice(
///  userId: 1,
///  email: 'email',
///  firstName: 'firstName',
///  lastName: 'lastName',
///  phone: 'phone',
///  isPhoneVerified: true,
///  isEmailVerified: true,
///  userType: UserType.police,
///  apiToken: 'apiToken',
///  photo: 'photo',
///  policeId: 'policeId',
///  thana: 'thana',
/// );
/// ```
class UserPolice extends User {
  final String policeId;
  final String thana;

  const UserPolice(
      {required this.policeId,
      required this.thana,
      super.email,
      required super.userId,
      required super.firstName,
      required super.lastName,
      required super.phone,
      required super.isPhoneVerified,
      required super.isEmailVerified,
      required super.userType,
      required super.apiToken,
      required super.photo});

  @override
  UserPolice copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    UserType? userType,
    String? apiToken,
    String? photo,
    String? policeId,
    String? thana,
  }) {
    return UserPolice(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      userType: userType ?? this.userType,
      apiToken: apiToken ?? this.apiToken,
      photo: photo ?? this.photo,
      policeId: policeId ?? this.policeId,
      thana: thana ?? this.thana,
    );
  }
}

/// [UserAmbulance] class extends [User]
///  ie:
///  ```dart
///  final user = UserAmbulance(
///  userId: 1,
///  email: 'email',
///  firstName: 'firstName',
///  lastName: 'lastName',
///  phone: 'phone',
///  isPhoneVerified: true,
///  isEmailVerified: true,
///  userType: UserType.ambulance,
///  apiToken: 'apiToken',
///  photo: 'photo',
///  hospitalOrAgency: 'hospitalOrAgency',
/// );
/// ```
class UserAmbulance extends User {
  final String hospitalOrAgency;

  const UserAmbulance(
      {required this.hospitalOrAgency,
      super.email,
      required super.userId,
      required super.firstName,
      required super.lastName,
      required super.phone,
      required super.isPhoneVerified,
      required super.isEmailVerified,
      required super.userType,
      required super.apiToken,
      required super.photo});

  @override
  UserAmbulance copyWith(
      {int? userId,
      String? firstName,
      String? lastName,
      String? email,
      String? phone,
      bool? isPhoneVerified,
      bool? isEmailVerified,
      UserType? userType,
      String? apiToken,
      String? photo,
      String? hospitalOrAgency}) {
    return UserAmbulance(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      userType: userType ?? this.userType,
      apiToken: apiToken ?? this.apiToken,
      photo: photo ?? this.photo,
      hospitalOrAgency: hospitalOrAgency ?? this.hospitalOrAgency,
    );
  }
}

/// [UserNone] class extends [User]
///  ie:
///  ```
///  final user = UserNone(
///  userId: 1,
///  email: 'email',
///  firstName: 'firstName',
///  lastName: 'lastName',
///  phone: 'phone',
///  isPhoneVerified: true,
///  isEmailVerified: true,
///  userType: UserType.none,
///  apiToken: 'apiToken',
///  photo: 'photo',
/// );
///  ```
///
///  [N.B] : this is a fallback user which will be used
///  when the user type is unknown
class UserNone extends User {
  const UserNone(
      {required super.userId,
      required super.firstName,
      required super.lastName,
      required super.phone,
      required super.email,
      required super.isPhoneVerified,
      required super.isEmailVerified,
      required super.userType,
      required super.apiToken,
      required super.photo});

  @override
  UserNone copyWith(
      {int? userId,
      String? firstName,
      String? lastName,
      String? email,
      String? phone,
      bool? isPhoneVerified,
      bool? isEmailVerified,
      UserType? userType,
      String? apiToken,
      String? photo}) {
    return UserNone(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      userType: userType ?? this.userType,
      apiToken: apiToken ?? this.apiToken,
      photo: photo ?? this.photo,
    );
  }
}
