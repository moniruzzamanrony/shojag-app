import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:equatable/equatable.dart';

class PremiumEntity extends Equatable {
  final bool isPremium;
  final DateTime expireDate;
  final String currentPackage;

  const PremiumEntity(
      {required this.isPremium,
      required this.expireDate,
      required this.currentPackage});

  bool get _isExpired => DateTime.now().isAfter(expireDate.dayEndTime);

  int get remainingDays => expireDate.difference(DateTime.now()).inDays;

  bool get _isNotExpired => !_isExpired;

  bool get _isFree => currentPackage == 'free';

  bool get _isNotFree => !_isFree;

  bool get isValidPremiumUser => isPremium && _isNotExpired && _isNotFree;

  // TODO: update before production
  factory PremiumEntity.empty() {
    return PremiumEntity(
        isPremium: false, //false
        expireDate: DateTime(1970),
        currentPackage: '' //'free'
        );
  }

  @override
  String toString() {
    return 'PremiumEntity(isPremium: $isPremium, expireDate: $expireDate, currentPackage: $currentPackage)';
  }

  @override
  List<Object?> get props => [isPremium, expireDate, currentPackage];
}
