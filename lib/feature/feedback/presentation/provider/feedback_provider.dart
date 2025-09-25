import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/feature/feedback/domain/usecase/send_user_review_use_case.dart';

import '../../../../core/utils/resource/dependency_injection.dart';

class FeedbackProvider extends BaseProvider {
  String _review = '';

  String get review => _review;

  set review(String value) {
    _review = value;
    notify();
  }

  bool get isValid => _review.trim().isNotEmpty;

  Future<bool> sendFeedback(
      {required String token, required int userId}) async {
    final sendFeedbackUseCase = getIt<SendUserReviewUseCase>();
    final result = await sendFeedbackUseCase(
        SendUserReviewParam(token: token, userId: userId, review: review));

    return result.fold((l) => Future.error(l.message), (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    _review = '';
  }
}
