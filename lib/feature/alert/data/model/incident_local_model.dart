import 'package:app/core/utils/constants/app_constants.dart';
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entity/incident_entity.dart';

class IncidentLocalModel {
  final int? id;
  final int categoryId;
  final String titleEn;
  final String titleBn;
  final String tags;
  final String? description;
  final bool isOnline;

  const IncidentLocalModel(
      {required this.id,
      required this.categoryId,
      required this.titleEn,
      required this.titleBn,
      required this.tags,
      required this.description,
      required this.isOnline});

  //entity to model
  factory IncidentLocalModel.fromEntity(IncidentEntity entity) {
    return IncidentLocalModel(
      id: entity.id,
      titleEn: entity.titleEn,
      titleBn: entity.titleBn,
      tags: entity.tags.join(AppConstants.arraySplitter),
      categoryId: entity.categoryId,
      description: entity.description,
      isOnline: entity.isOnline,
    );
  }

  //model to entity
  IncidentEntity toEntity() {
    return IncidentEntity(
        id: id,
        titleEn: titleEn,
        titleBn: titleBn,
        tags: tags.split(AppConstants.arraySplitter),
        categoryId: categoryId,
        description: description,
        isOnline: isOnline);
  }

  //from drift row to  model
  factory IncidentLocalModel.fromDriftRow(TableIncidentCompanion row) {
    return IncidentLocalModel(
        id: row.id.value,
        titleEn: row.titleEn.value,
        titleBn: row.titleBn.value,
        tags: row.tags.value,
        categoryId: row.categoryId.value,
        description: row.description.value,
        isOnline: row.isOnline.value);
  }

  //model to a drift database object
  TableIncidentCompanion toDriftCompanion() {
    return TableIncidentCompanion(
        id: Value.absentIfNull(id),
        categoryId: Value(categoryId),
        titleEn: Value(titleEn),
        titleBn: Value(titleBn),
        tags: Value(tags),
        description: Value.absentIfNull(description),
        isOnline: Value(isOnline));
  }
}
