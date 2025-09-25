/// [UserType] is an enum that contains the different types of users that can be logged in.<br>
///
/// [citizen] is the citizen user type. <br>
/// [police] is the police user type. <br>
/// [fireService] is the fire service user type. <br>
/// [ambulance] is the ambulance user type. <br>
/// [none] is the none user type. it is used for fallback
///
/// Can be retrieved from id by calling [UserType.fromId] and title by calling [UserType.fromTitle]
///
enum UserType {
  none(0, 'none', 'None', 'নাই'),
  citizen(1, 'citizen', 'Citizen', 'সিটিজেন'),
  police(2, 'police', 'Police', 'পুলিশ'),
  fireService(3, 'fire_service', 'Fire Service', 'ফায়ার সার্ভিস'),
  ambulance(4, 'ambulance', 'Ambulance', 'অ্যাম্বুলেন্স');

  final int id;
  final String value;
  final String titleEn;
  final String titleBn;

  static List<UserType> get list => List.of(UserType.values)..remove(none);

  const UserType(this.id, this.value, this.titleEn, this.titleBn);

  factory UserType.fromTitle(String? title) {
    switch (title) {
      case 'Citizen':
        return UserType.citizen;
      case 'Police':
        return UserType.police;
      case 'Fire Service':
        return UserType.fireService;
      case 'Ambulance':
        return UserType.ambulance;
      default:
        return UserType.none;
    }
  }

  factory UserType.fromId(int? id) {
    switch (id) {
      case 1:
        return UserType.citizen;
      case 2:
        return UserType.police;
      case 3:
        return UserType.fireService;
      case 4:
        return UserType.ambulance;
      default:
        return UserType.none;
    }
  }
}
