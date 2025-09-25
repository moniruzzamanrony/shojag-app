import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [Dimens] class contains all the dimensions used in the app
/// it also contains all the font sizes used in the app
/// along with all the border radius, padding and margin and icon sizes
/// Also other dimensions like height, width and sizes
abstract class Dimens {
  const Dimens._();

  static const maxMobileWidthBreakPoint = 600.0;
  static const desktopBreakpoint = 1200.0;

  static final double horizontalSpace = 16.w;
  static final double verticalSpace = 16.h;

  static final double bottomNavHeight = 90.h;

  // font sizes
  static final double fontSize10 = 10.sp;
  static final double fontSize11 = 11.sp;
  static final double fontSize12 = 12.sp;
  static final double fontSize16 = 16.sp;
  static final double fontSize14 = 14.sp;
  static final double fontSize18 = 18.sp;
  static final double fontSize20 = 20.sp;
  static final double fontSize24 = 24.sp;
  static final double fontSize25 = 25.sp;
  static final double fontSize30 = 30.sp;
  static final double fontSize35 = 35.sp;
  static final double fontSize40 = 40.sp;

  // border radius
  static final double borderRadius6 = 6.r;
  static final double borderRadius8 = 8.r;
  static final double borderRadius10 = 10.r;
  static final double borderRadius12 = 12.r;
  static final double borderRadius16 = 16.r;
  static final double borderRadius20 = 20.r;
  static final double borderRadius24 = 24.r;
  static final double borderRadius28 = 28.r;
  static final double borderRadius30 = 30.r;

  //padding
  static final double padding4 = 4.r;
  static final double padding6 = 6.r;
  static final double padding8 = 8.r;
  static final double padding10 = 10.r;
  static final double padding12 = 12.r;
  static final double padding16 = 16.r;
  static final double padding20 = 20.r;
  static final double padding24 = 24.r;
  static final double padding28 = 28.r;
  static final double padding32 = 32.r;
  static final double padding40 = 40.r;
  static final double padding48 = 48.r;

  // icon size
  static final double iconSize10 = 10.sp;
  static final double iconSize11 = 11.sp;
  static final double iconSize12 = 12.sp;
  static final double iconSize14 = 14.sp;
  static final double iconSize16 = 16.sp;
  static final double iconSize18 = 18.sp;
  static final double iconSize20 = 20.sp;
  static final double iconSize24 = 24.sp;
  static final double iconSize28 = 28.sp;
  static final double iconSize32 = 32.sp;
  static final double iconSize36 = 36.sp;
  static final double iconSize40 = 40.sp;

  static const double itemSize10 = 10.0;
  static const double itemSize60 = 60.0;

  // button height and width
  static final double buttonHeight = 40.h;
}
