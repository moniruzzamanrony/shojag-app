import 'package:app/core/error/data_state.dart';
import 'package:app/feature/feedback/data/model/feedback_send_remote_post_model.dart';
import 'package:app/feature/feedback/data/model/feedback_send_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/feedback_repository.dart';

class FeedbackRepositoryImpl extends FeedbackRepository {
  const FeedbackRepositoryImpl({required super.remoteService});

  @override
  Future<Either<Failure, FeedbackSendRemoteResponseModel>> sendFeedbackRemote(
      {required String token, required FeedbackSendRemotePostModel model}) {
    return remoteService.sendFeedback(token: token, model: model);
  }
}
