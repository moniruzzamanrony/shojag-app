import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

/// [AnnotationClickListener] is a class that implements the [OnPointAnnotationClickListener] interface.
/// It defines a callback function [onAnnotationClick] that is called when a point annotation is clicked.
/// This class is used to handle point annotation clicks in a map.
/// The [onAnnotationClick] function is called when a point annotation is clicked.
/// It takes a [PointAnnotation] as a parameter.
class AnnotationClickListener extends OnPointAnnotationClickListener {
  final void Function(PointAnnotation annotation) onAnnotationClick;

  AnnotationClickListener({required this.onAnnotationClick});

  @override
  void onPointAnnotationClick(PointAnnotation annotation) =>
      onAnnotationClick(annotation);
}