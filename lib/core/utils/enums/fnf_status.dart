/// [FnfStatus] enum is used to represent the status of the fnf<br>
/// [none], [pending], [accepted]
///
enum FnfStatus {
  none(0, 'none', 'None'),
  pending(1, 'pending', 'Pending'),
  accepted(2, 'accepted', 'Accepted');

  final int id;
  final String value;
  final String title;

  const FnfStatus(this.id, this.value, this.title);

  factory FnfStatus.fromId(int id) {
    switch (id) {
      case 1:
        return pending;
      case 2:
        return accepted;
      default:
        return none;
    }
  }
}
