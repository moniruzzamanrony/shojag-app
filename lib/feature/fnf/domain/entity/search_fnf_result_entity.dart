import 'package:app/core/utils/enums/fnf_status.dart';
import 'package:equatable/equatable.dart';

class SearchFnfResultEntity extends Equatable {
  final int userId;
  final String userName;
  final String userPhone;
  final String? userImage;
  final FnfStatus fnfStatus;

  const SearchFnfResultEntity({
    required this.userId,
    required this.userName,
    required this.userPhone,
    this.userImage,
    required this.fnfStatus,
  });

  @override
  List<Object?> get props =>
      [userId, userName, userPhone, userImage, fnfStatus];
}
