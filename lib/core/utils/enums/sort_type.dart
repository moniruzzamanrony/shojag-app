/// [SortType] enum is used to represent the sort type
enum SortType {
  date('Date', 'তারিখ'),
  distance('Distance', 'দুরুত্ব');

  final String titleEn;
  final String titleBn;

  const SortType(this.titleEn, this.titleBn);
}
