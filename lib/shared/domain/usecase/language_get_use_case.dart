import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/language_entity.dart';
import '../repository/common_repository.dart';

/// This use case is responsible for retrieving the language,
/// typically used to determine the language of the app.
///
/// Depends on [CommonRepository], which provides the necessary methods to
/// retrieve the language.
class LanguageGetUseCase
    implements UseCaseWithOutFuture<LanguageEntity, NoParams> {
  final CommonRepository repository;

  const LanguageGetUseCase(this.repository);

  @override
  Either<Failure, LanguageEntity> call(NoParams params) {
    final session = repository.getLanguage();
    return session.fold(
      (l) => Left(l),
      (r) {
        return Right(LanguageEntity(locale: r.language, name: r.language));
      },
    );
  }
}
