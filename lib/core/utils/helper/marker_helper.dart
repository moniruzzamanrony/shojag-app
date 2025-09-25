// this file [marker_helper.dart] is for the marker helper
// this file is used to generate the marker
// it generate custom marker with custom shape

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:screenshot/screenshot.dart';

import '../../config/theme/app_colors.dart';

Widget _customMarker(Widget child,
    {String? title,
    String? snippet,
    required bool customShape,
    required Color markerBgColor,
    required double scale}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (title != null || snippet != null) ...[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: AppColors.colorWhite.withValues(alpha: 0.96),
              borderRadius: BorderRadius.circular(30.0)),
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                if (title != null)
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                if (title != null && snippet != null)
                  const TextSpan(text: '\n'),
                TextSpan(
                  text: snippet,
                  style: const TextStyle(
                    color: AppColors.colorAppGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            style: const TextStyle(height: 1.0),
          ),
        ),
        const Gap(4),
      ],
      if (customShape)
        Transform.scale(
          scale: scale,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              FaIcon(
                FontAwesomeIcons.locationPin,
                size: 60,
                color: markerBgColor,
              ),
              // FaIcon(
              //   FontAwesomeIcons.caretDown,
              //   size: 60,
              //   color: markerBgColor,
              // ),
              Container(
                height: 44,
                width: 44,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  shape: BoxShape.circle,
                  border: Border.all(color: markerBgColor, width: 2.5),
                ),
                child: ClipOval(child: child),
              ),
            ],
          ),
        )
      else
        child,
    ],
  );
}

Future<Uint8List?> generateMapIconsWithShape(String asset,
    {String? title,
    String? snippet,
    double scale = 1.0,
    bool customShape = true,
    Color markerBgColor = AppColors.colorAppGreen}) async {
  try {
    ScreenshotController screenshotController = ScreenshotController();
    final child = Image.asset(asset, height: 40, fit: BoxFit.fill);
    final image = await screenshotController.captureFromWidget(
        delay: const Duration(milliseconds: 50),
        _customMarker(child,
            title: title,
            snippet: snippet,
            scale: scale,
            customShape: customShape,
            markerBgColor: markerBgColor));

    return image;
  } catch (e) {
    return null;
  }
}

Future<Uint8List?> generateNetworkMapIconsWithShape(String url,
    {String? title,
    String? snippet,
    double scale = 1.0,
    Color markerBgColor = AppColors.colorAppGreen}) async {
  final completer = Completer<ImageInfo?>();
  try {
    var image = NetworkImage(url);
    image.resolve(const ImageConfiguration()).addListener(ImageStreamListener(
            (info, _) => completer.complete(info), onError: (e, stackTrace) {
          completer.complete(null);
        }));
  } catch (e) {
    completer.complete(null);
  }

  final info = await completer.future;
  if (info == null) return null;

  final byteData = await info.image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = byteData?.buffer.asUint8List();
  if (bytes == null) return null;

  try {
    ScreenshotController screenshotController = ScreenshotController();
    final image = await screenshotController.captureFromWidget(
      delay: const Duration(milliseconds: 50),
      Transform.scale(
        scale: scale,
        child: _customMarker(Image.memory(bytes, fit: BoxFit.fill),
            title: title,
            snippet: snippet,
            scale: 1.0,
            customShape: true,
            markerBgColor: markerBgColor),
      ),
    );

    return image;
  } catch (e) {
    return null;
  }
}
