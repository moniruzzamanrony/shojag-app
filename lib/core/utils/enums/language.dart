/// [Language] enum is used to represent the language of the app
///
/// [bangla], [english]
///
/// Other languages can be added here
enum Language {
  en('en', 'English', 'English'),
  bn('bn', 'Bangla', 'বাংলা');

  final String shortName;
  final String name;
  final String nativeName;

  const Language(this.shortName, this.name, this.nativeName);
}
