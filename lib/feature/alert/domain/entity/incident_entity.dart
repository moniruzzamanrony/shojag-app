class IncidentEntity {
  final int? id;
  final int categoryId;
  final String titleEn;
  final String titleBn;
  final List<String> tags;
  final String? description;
  final bool isOnline;

  const IncidentEntity({
    required this.id,
    required this.categoryId,
    required this.titleEn,
    required this.titleBn,
    required this.tags,
    this.description,
    required this.isOnline,
  });
}
