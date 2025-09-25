import '../../../../core/utils/enums/sort_type.dart';

class AlertGetListRemoteParam {
  final String token;
  final int userId;
  final int page;
  final SortType sortBy;

  const AlertGetListRemoteParam({
    required this.token,
    required this.userId,
    required this.page,
    required this.sortBy,
  });
}