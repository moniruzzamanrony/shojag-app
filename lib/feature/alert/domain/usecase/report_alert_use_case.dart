import 'package:app/feature/alert/data/model/report/alert_report_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class ReportAlertUseCase implements UseCase<bool, ReportAlertParams> {
  final AlertRepository repository;

  const ReportAlertUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ReportAlertParams params) async {
    final response = await repository.reportAlertRemote(
        token: params.token,
        model: AlertReportRemotePostModel(
          alertId: params.alertId,
          userId: params.userId,
          comment: params.comment,
        ));
    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.success == true) {
          return const Right(true);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class ReportAlertParams {
  final String token;
  final int userId;
  final int alertId;
  final String comment;

  const ReportAlertParams(
      {required this.token,
      required this.userId,
      required this.alertId,
      required this.comment});
}
