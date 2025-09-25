import 'package:app/core/network/base_api_service.dart';
import 'package:app/feature/feedback/data/model/feedback_send_remote_post_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../model/feedback_send_remote_response_model.dart';

abstract class IFeedbackRemoteService {
  final BaseApiService apiService;

  const IFeedbackRemoteService(this.apiService);

  Future<Either<Failure, FeedbackSendRemoteResponseModel>> sendFeedback({
    required String token,
    required FeedbackSendRemotePostModel model,
  });
}

class FeedbackRemoteService extends IFeedbackRemoteService {
  const FeedbackRemoteService(super.apiService);

  @override
  Future<Either<Failure, FeedbackSendRemoteResponseModel>> sendFeedback({
    required String token,
    required FeedbackSendRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.feedbackSendEndPoint,
      data: model.toMap(),
      fromJson: FeedbackSendRemoteResponseModel.fromJson,
    );
  }
}
