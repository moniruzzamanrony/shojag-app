import 'dart:async';

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/alert/presentation/update/provider/alert_update_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/helper/location_helper.dart';
import '../../../../consent/presentation/widget/consent_checker.dart';
import '../../create/widget/location_bottom_sheet_view.dart';
import '../../create/widget/media_button_widget.dart';

class AlertUpdateLocationWidget extends StatelessWidget {
  const AlertUpdateLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AlertUpdateProvider, LatLng?>(
      selector: (_, provider) => provider.selectedLatLng,
      builder: (_, value, __) {
        Completer<Placemark?> completer = Completer<Placemark?>();
        if (value != null) {
          LocationHelper.getPlaceMarks(latLng: value).then(
            (v) {
              if (v.isNotEmpty) {
                completer.complete(v.first);
              } else {
                completer.complete();
              }
            },
          );
        } else {
          completer.complete();
        }
        String? place;
        return FutureBuilder(
          future: completer.future,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              place = LocationHelper.placeMarkToPlaceString(snapshot.data!);
            }
            context.read<AlertUpdateProvider>().geoAddress = place;

            return MediaUploadButtonWidget(
              hintText: context.language.selectAlertLocation,
              text: place,
              icon: Icons.my_location_outlined,
              onTap: () {
                hideAppKeyboard(context);
                _showLocationView(context);
              },
            );
          },
        );
      },
    );
  }

  // show location page on map and select location
  void _showLocationView(BuildContext ctx) async {
    final hasPermission = await consentChecker(ctx);
    if (!hasPermission || !ctx.mounted) {
      return;
    }
    ctx.read<AlertUpdateProvider>().scaffoldKey.currentState?.showBottomSheet(
        shape: const RoundedRectangleBorder(),
        backgroundColor: Colors.black38,
        enableDrag: false,
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(ctx).height),
        (context) => LocationBottomSheetView(
            center:
                context.read<AlertUpdateProvider>().selectedLatLng,
            onConfirm: (latLng) async {
              context.read<AlertUpdateProvider>().selectedLatLng = latLng;
              context.pop();
            }));
  }
}
