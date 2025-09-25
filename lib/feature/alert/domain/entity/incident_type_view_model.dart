import 'package:app/core/utils/enums/alert_type.dart';
import 'package:equatable/equatable.dart';

class IncidentTypeViewModel extends Equatable {
  final int id;
  final String titleEn;
  final String titleBn;
  final List<String> tags;
  final AlertType type;

  const IncidentTypeViewModel(
      {required this.id,
      required this.titleEn,
      required this.titleBn,
      required this.tags,
      required this.type});

  @override
  List<Object?> get props => [id, titleEn, titleBn, tags, type];
}
