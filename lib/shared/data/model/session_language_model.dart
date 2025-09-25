import 'package:hive_ce/hive.dart';

import '../../../core/utils/constants/app_constants.dart';
import 'hive_types.dart';

part 'session_language_model.g.dart';

/// This class represents a model for storing the language of the app.
/// It has a field `language` of type `String`, which is the language code.
///
/// The `SessionLanguageModel` class is annotated with the `HiveType` annotation,
/// which specifies the type ID for the Hive adapter.
@HiveType(typeId: sessionLanguageTypeId)
class SessionLanguageModel {
  @HiveField(0, defaultValue: 'en')
  final String language;

  const SessionLanguageModel({required this.language});

  factory SessionLanguageModel.defaultLanguage() =>
      const SessionLanguageModel(language: AppConstants.defaultLanguageLocale);
}
