import 'package:app/shared/domain/entity/distance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// extension for num
extension NumberExtension on num {
  /// Convert [num] to [String]
  String get moneyNumberFormat {
    final format = NumberFormat(",###");
    return format.format(this);
  }

  /// Convert [num] to [String]
  String get moneyNumberFormatWithDecimal {
    final format = NumberFormat(",##0.00");
    return format.format(this);
  }

  /// Convert [num] to [String]
  String get locationLatLngFormat {
    final format = NumberFormat("##0.00");
    return format.format(this);
  }

  /// Convert [num] to [String]
  String get doubleOrIntString {
    final format = NumberFormat('0.##');
    return format.format(this);
  }

  /// Convert [num] to [String]
  String get timeFormat {
    final format = NumberFormat(
      "00",
    );
    return format.format(this);
  }

  /// Convert [num] to [String]
  String get meterToKm {
    return (this / 1000).toStringAsFixed(2);
  }

  /// Convert [num] to [DistanceEntity]
  DistanceEntity get kmToDistanceModel {
    if (this > 1) {
      return DistanceEntity(distance: this, unit: DistanceUnit.km);
    }
    return DistanceEntity(distance: (this * 1000), unit: DistanceUnit.meter);
  }

  /// Convert [num] to [SizedBox]
  SizedBox get wBox {
    return SizedBox(width: w);
  }

  /// Convert [num] to [SizedBox]
  SizedBox get hBox {
    return SizedBox(height: h);
  }

  /// Convert [num] to [Gap]
  Gap get gapH {
    return Gap(h);
  }

  /// Convert [num] to [Gap]
  Gap get gapW {
    return Gap(w);
  }

  /// Convert [num] to [Gap]
  Gap get gapR {
    return Gap(r);
  }

  /// Convert [num] to [SliverGap]
  SliverGap get sliverGap {
    return SliverGap(r);
  }

  /// Convert [num] to [SliverGap] with color
  SliverGap sliverGapBgColor(Color color) {
    return SliverGap(toDouble(), color: color);
  }
}
