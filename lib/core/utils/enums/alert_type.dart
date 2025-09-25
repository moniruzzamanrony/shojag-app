import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/widgets.dart';

/// [AlertType] is an enum that contains the different types of alerts that can be made.<br>
///
/// [community] is the community alert type. <br>
/// [police] is the police alert type. <br>
/// [fireService] is the fire service alert type. <br>
/// [ambulance] is the ambulance alert type. <br>
/// [none] is the none alert type.
///
/// Can be retrieved from id by calling [AlertType.fromId] <br>
enum AlertType {
  community(1, 'community', 'Community', 'কমিউনিটি'),
  police(2, 'police', 'Police', 'পুলিশ'),
  fireService(3, 'fire_service', 'Fire Service', 'ফায়ার সার্ভিস'),
  ambulance(4, 'ambulance', 'Ambulance', 'অ্যাম্বুলেন্স'),
  none(0, 'none', 'None', 'নাই');

  static List<AlertType> get list => List.of(AlertType.values)..remove(none);

  final int id;
  final String value;
  final String titleEn;
  final String titleBn;

  const AlertType(this.id, this.value, this.titleEn, this.titleBn);

  String title(BuildContext context) {
    return context.isBangla ? titleBn : titleEn;
  }

  factory AlertType.fromId(int id) {
    switch (id) {
      case 1:
        return community;
      case 2:
        return police;
      case 3:
        return fireService;
      case 4:
        return ambulance;
      default:
        return none;
    }
  }
}
