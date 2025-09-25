import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/session_auth_model.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for saving the session,
///  typically used when the user logs in or signs in.
///
///  Depends on [CommonRepository], which provides the necessary methods to
///  save the session.
class SessionSaveUseCase implements UseCase<void, SessionSaveParams> {
  final CommonRepository repository;

  const SessionSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SessionSaveParams params) async {
    return await repository.saveAuthSession(SessionAuthModel(
        loginStatus: params.loginStatus,
        apiToken: params.apiToken,
        userId: params.userId,
        email: params.email,
        lastName: params.lastName,
        firstName: params.firstName,
        phone: params.phone,
        photo: params.photo,
        nid: params.nid,
        address: params.address,
        dob: params.dob,
        gender: params.gender,
        userType: params.userType,
        thana: params.thana,
        policeId: params.policeId,
        hospitalOrAgency: params.hospitalOrAgency,
        fireStation: params.fireStation,
        isPhoneVerified: params.isPhoneVerified,
        isEmailVerified: params.isEmailVerified));
  }
}

class SessionSaveParams {
  bool loginStatus;
  int userId;
  String apiToken;
  String firstName;
  String lastName;
  String phone;
  String? email;
  String? gender;
  String? dob;
  String? nid;
  String? address;
  String? photo;
  String? policeId;
  String? thana;
  String? fireStation;
  String? hospitalOrAgency;
  bool isEmailVerified;
  bool isPhoneVerified;
  int userType;

  SessionSaveParams({
    required this.loginStatus,
    required this.userId,
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
    required this.userType,
  });

  SessionSaveParams copyWith({
    bool? loginStatus,
    int? userId,
    String? apiToken,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? gender,
    String? dob,
    String? nid,
    String? address,
    String? photo,
    String? policeId,
    String? thana,
    String? fireStation,
    String? hospitalOrAgency,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    int? userType,
  }) {
    return SessionSaveParams(
      loginStatus: loginStatus ?? this.loginStatus,
      userId: userId ?? this.userId,
      apiToken: apiToken ?? this.apiToken,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      nid: nid ?? this.nid,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      policeId: policeId ?? this.policeId,
      thana: thana ?? this.thana,
      fireStation: fireStation ?? this.fireStation,
      hospitalOrAgency: hospitalOrAgency ?? this.hospitalOrAgency,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      userType: userType ?? this.userType,
    );
  }
}
