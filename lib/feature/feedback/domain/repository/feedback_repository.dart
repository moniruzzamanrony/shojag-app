import 'package:app/feature/feedback/data/service/feedback_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/feedback_send_remote_post_model.dart';
import '../../data/model/feedback_send_remote_response_model.dart';

abstract class FeedbackRepository {
  final IFeedbackRemoteService remoteService;

  const FeedbackRepository({required this.remoteService});

  Future<Either<Failure, FeedbackSendRemoteResponseModel>> sendFeedbackRemote(
      {required String token, required FeedbackSendRemotePostModel model});
}
