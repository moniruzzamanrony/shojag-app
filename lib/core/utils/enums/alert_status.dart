/// [AlertStatus] enum is used to represent the status of the alert
/// it may be [active], [closed]
/// and [none] here used for fallback value
enum AlertStatus {
  active(1, 'active', 'Active'),
  closed(3, 'closed', 'Closed'),
  none(0, 'none', 'None');

  static List<AlertStatus> get list =>
      List.of(AlertStatus.values)..remove(none);

  final int id;
  final String value;
  final String title;

  const AlertStatus(this.id, this.value, this.title);

  factory AlertStatus.fromId(int id) {
    switch (id) {
      case 1:
        return active;
      case 3:
        return closed;
      default:
        return none;
    }
  }
}
