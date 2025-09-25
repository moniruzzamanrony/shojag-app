import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';

import '../../config/theme/app_colors.dart';
import '../constants/dimens.dart';

/// [Styles] is a class that contains all the styles used in the app
abstract class Styles {
  /// [boxShadow] is a method that returns a list of shadows
  static List<BoxShadow> boxShadow(
          {Color? color,
          double? colorOpacity,
          double? blurRadius,
          double? spreadRadius,
          BlurStyle blurStyle = BlurStyle.outer,
          Offset? offset,
          List<BoxShadow>? customShadow}) =>
      customShadow ??
      [
        BoxShadow(
            color: color?.withValues(alpha: colorOpacity ?? 1) ??
                AppColors.colorBlack.withValues(alpha: colorOpacity ?? 0.2),
            spreadRadius: spreadRadius ?? 0,
            blurStyle: blurStyle,
            blurRadius: blurRadius ?? 4,
            offset: offset ?? Offset.zero)
      ];

  static m.VisualDensity get minimumVisualDensity => const m.VisualDensity(
      horizontal: m.VisualDensity.minimumDensity,
      vertical: m.VisualDensity.minimumDensity);

  static DecoratedBox kDecoratedBox = const DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: m.Colors.white,
    ),
  );

  static BorderRadius curvedTopBorderRadius = const BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  );

  /// [horizontalPadding] is a method that returns a symmetric padding only [horizontal]
  static final horizontalPadding =
      EdgeInsets.symmetric(horizontal: Dimens.horizontalSpace);

  /// [verticalPadding] is a method that returns a symmetric padding only [vertical]
  static final verticalPadding =
      EdgeInsets.symmetric(vertical: Dimens.verticalSpace);

  /// [horVerPadding] is a method that returns a symmetric padding both [horizontal] and [vertical]
  static final horVerPadding = EdgeInsets.symmetric(
      horizontal: Dimens.horizontalSpace, vertical: Dimens.verticalSpace);

  static final tileColorGrey = AppColors.colorWhite;
}
