import 'package:app/feature/feedback/data/model/feedback_send_remote_post_model.dart';
import 'package:app/feature/feedback/domain/repository/feedback_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class SendUserReviewUseCase implements UseCase<bool, SendUserReviewParam> {
  final FeedbackRepository repository;

  const SendUserReviewUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendUserReviewParam params) async {
    final response = await repository.sendFeedbackRemote(
        token: params.token,
        model: FeedbackSendRemotePostModel(
            userId: params.userId, review: params.review));
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

class SendUserReviewParam {
  final String token;
  final int userId;
  final String review;

  const SendUserReviewParam({
    required this.token,
    required this.userId,
    required this.review,
  });
}
