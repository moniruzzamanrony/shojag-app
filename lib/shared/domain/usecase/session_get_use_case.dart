import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/helper/datetime_helper.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/enums/gender.dart';
import '../entity/session_auth_entity.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the session,
/// typically used to check if the user is logged in and
/// retrieve the user if any
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the session.
class SessionGetUseCase
    implements UseCaseWithOutFuture<SessionAuthEntity?, NoParams> {
  final CommonRepository repository;

  const SessionGetUseCase(this.repository);

  @override
  Either<Failure, SessionAuthEntity?> call(NoParams params) {
    final session = repository.getAuthSession();
    return session.fold(
      (l) => Left(l),
      (r) {
        if (r == null) {
          return const Right(null);
        }
        final userType = UserType.fromId(r.userType);
        User user;

        switch (userType) {
          case UserType.citizen:
            user = UserCitizen(
              userId: r.userId,
              firstName: r.firstName,
              lastName: r.lastName,
              email: r.email,
              phone: r.phone,
              isPhoneVerified: r.isPhoneVerified,
              isEmailVerified: r.isEmailVerified,
              userType: UserType.fromId(r.userType),
              gender: Gender.fromTitle(r.gender ?? ''),
              dob: getDateTimeFromString(date: r.dob),
              nid: r.nid,
              address: r.address,
              photo: r.photo,
              apiToken: r.apiToken,
            );
            break;
          case UserType.police:
            user = UserPolice(
              userId: r.userId,
              firstName: r.firstName,
              lastName: r.lastName,
              email: r.email,
              phone: r.phone,
              isPhoneVerified: r.isPhoneVerified,
              isEmailVerified: r.isEmailVerified,
              userType: UserType.fromId(r.userType),
              photo: r.photo,
              policeId: r.policeId ?? '0',
              thana: r.thana ?? '',
              apiToken: r.apiToken,
            );
            break;
          case UserType.fireService:
            user = UserFireService(
              userId: r.userId,
              firstName: r.firstName,
              lastName: r.lastName,
              email: r.email,
              phone: r.phone,
              isPhoneVerified: r.isPhoneVerified,
              isEmailVerified: r.isEmailVerified,
              userType: userType,
              photo: r.photo,
              apiToken: r.apiToken,
              fireStation: r.fireStation ?? '',
            );
            break;
          case UserType.ambulance:
            user = UserAmbulance(
              userId: r.userId,
              firstName: r.firstName,
              lastName: r.lastName,
              email: r.email,
              phone: r.phone,
              isPhoneVerified: r.isPhoneVerified,
              isEmailVerified: r.isEmailVerified,
              userType: userType,
              photo: r.photo,
              apiToken: r.apiToken,
              hospitalOrAgency: r.hospitalOrAgency ?? '',
            );
            break;
          case UserType.none:
            user = UserNone(
              userId: r.userId,
              firstName: r.firstName,
              lastName: r.lastName,
              phone: r.phone,
              isPhoneVerified: r.isPhoneVerified,
              isEmailVerified: r.isEmailVerified,
              userType: userType,
              photo: r.photo,
              apiToken: r.apiToken,
              email: r.email,
            );
            break;
        }

        return Right(SessionAuthEntity(isLoggedIn: r.loginStatus, user: user));
      },
    );
  }
}
