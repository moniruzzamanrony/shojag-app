/* *
custom map marker model
 */

import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class MapMarker extends Equatable {
  final String markerId;
  final String? title;
  final String? snippet;
  final double latitude;
  final double longitude;
  final String? iconUrl;
  final Uint8List? image;

  const MapMarker({
    required this.markerId,
    this.title,
    this.snippet,
    required this.latitude,
    required this.longitude,
    this.iconUrl,
    this.image,
  });

  bool isEqual(MapMarker other) => this == other;

  @override
  List<Object?> get props => [
        markerId,
        title,
        snippet,
        latitude,
        longitude,
        iconUrl,
        image,
      ];
}
