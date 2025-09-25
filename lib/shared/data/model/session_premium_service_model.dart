import 'package:app/shared/data/model/hive_types.dart';
import 'package:hive_ce/hive.dart';

part 'session_premium_service_model.g.dart';

/// This class represents a model for storing premium service information.
/// It has a field `isPremium` of type `bool`, which is used to indicate whether the user is premium or not.
/// It has a field `expireDate` of type `DateTime`, which is used to store the expiration date of the premium service.
/// It has a field `currentPackage` of type `String`, which is used to store the current package of the premium service.
///
/// The `SessionPremiumServiceModel` class is annotated with the `HiveType` annotation,
/// which specifies the type ID for the Hive adapter.
@HiveType(typeId: sessionPremiumServiceTypeId)
class SessionPremiumServiceModel {
  @HiveField(0, defaultValue: false)
  final bool isPremium;
  @HiveField(1)
  final DateTime expireDate;
  @HiveField(2, defaultValue: 'none')
  final String currentPackage;

  const SessionPremiumServiceModel({
    required this.isPremium,
    required this.expireDate,
    required this.currentPackage,
  });

  SessionPremiumServiceModel copyWith({
    bool? isPremium,
    DateTime? expireDate,
    String? currentPackage,
  }) {
    return SessionPremiumServiceModel(
      isPremium: isPremium ?? this.isPremium,
      expireDate: expireDate ?? this.expireDate,
      currentPackage: currentPackage ?? this.currentPackage,
    );
  }

  factory SessionPremiumServiceModel.initial() => SessionPremiumServiceModel(
      isPremium: false, expireDate: DateTime(1970), currentPackage: 'none');
}
