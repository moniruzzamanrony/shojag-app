/// [ListType] enum is used to represent the list type
///
/// [active], [closed], [responded], [myAlerts]
///
/// ListType.fromValue(int value) is used to get the list type from the value
enum ListType {
  active(0, 'active', 'সক্রিয়'),
  closed(1, 'closed', 'বন্ধ'),
  responded(2, 'responded', 'প্রতিক্রিয়া'),
  myAlerts(3, 'my', 'আমার');

  final int value;
  final String titleEn;
  final String titleBn;

  const ListType(this.value, this.titleEn, this.titleBn);

  factory ListType.fromValue(int v) {
    switch (v) {
      case 0:
        return ListType.active;
      case 1:
        return ListType.closed;
      case 2:
        return ListType.responded;
      case 3:
        return ListType.myAlerts;
      default:
        return ListType.active;
    }
  }
}
