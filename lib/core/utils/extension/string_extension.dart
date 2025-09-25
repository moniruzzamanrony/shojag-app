/// extension for String?
extension StringExtention on String? {
  /// Convert [String] to capitalize
  String toCapitalize() {
    if (this?.isEmpty ?? true) {
      return '';
    }
    return "${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}";
  }

  /// Convert [String] to title case
  String get toTitleCase {
    if (this?.isEmpty ?? true) {
      return '';
    }
    return "${this?.split(' ').map((e) => e.toCapitalize()).join(' ')}";
  }

  /// Convert [String] to [DateTime]
  DateTime? get toDateTime {
    if (this == null || this!.isEmpty) {
      return null;
    }
    try {
      final dateTime = DateTime.parse(this!);
      return dateTime;
    } catch (e) {
      return null;
    }
  }
}
