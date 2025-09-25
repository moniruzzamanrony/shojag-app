/// [Gender] enum is used to represent the gender of the user<br>
///
/// [Gender.male] represents the male gender<br>
/// [Gender.female] represents the female gender<br>
/// [Gender.other] represents the other gender<br>
/// [Gender.none] represents the none gender, for fallback<br>
///
/// It can be retrieved from the [Gender.fromValue] function or the [Gender.fromTitle] function
enum Gender {
  none(0, 'None',''),
  male(1, 'Male', 'পুরুষ'),
  female(2, 'Female', 'মহিলা'),
  other(3, 'Other', 'অন্যান্য');

  final int value;
  final String titleEn;
  final String titleBn;

  const Gender(this.value, this.titleEn, this.titleBn);

  static List<Gender> get list => List.of(Gender.values)..remove(none);

  factory Gender.fromValue(int v) {
    switch (v) {
      case 1:
        return Gender.male;
      case 2:
        return Gender.female;
      case 3:
        return Gender.other;
      default:
        return Gender.other;
    }
  }

  factory Gender.fromTitle(String t) {
    switch (t) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      case 'Other':
        return Gender.other;
      default:
        return Gender.other;
    }
  }
}
