import 'package:app/shared/data/model/session_language_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/common_repository.dart';

///Responsible for saving the language
/// Typically used when the user logs in or signs in.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// save the language.

class LanguageSaveUseCase implements UseCase<void, LanguageSaveParams> {
  final CommonRepository repository;

  const LanguageSaveUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LanguageSaveParams params) async {
    return await repository
        .saveLanguage(SessionLanguageModel(language: params.language));
  }
}

class LanguageSaveParams {
  final String language;

  const LanguageSaveParams({required this.language});
}
