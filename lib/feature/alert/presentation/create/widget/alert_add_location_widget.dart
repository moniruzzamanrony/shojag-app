import 'dart:async';

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/consent/presentation/widget/consent_checker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/helper/location_helper.dart';
import '../provider/alert_add_provider.dart';
import 'location_bottom_sheet_view.dart';
import 'media_button_widget.dart';

/// UI [AlertAddLocationWidget] for alert add location
class AlertAddLocationWidget extends StatelessWidget {
  const AlertAddLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AlertAddProvider, LatLng?>(
      selector: (_, provider) => provider.selectedLatLng,
      builder: (_, latLng, __) {
        Completer<Placemark?> completer = Completer<Placemark?>();
        if (latLng == null) {
          completer.complete();
        } else {
          //print(latLng.toJson());
          LocationHelper.getPlaceMarks(latLng: latLng).then(
            (placeMarks) {

              if (placeMarks.isNotEmpty) {
                completer.complete(placeMarks.first);
              } else {
                completer.complete();
              }
            },
          );
        }

        String? place;
        return FutureBuilder(
          future: completer.future,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              place = LocationHelper.placeMarkToPlaceString(snapshot.data!);
            }
            context.read<AlertAddProvider>().geoAddress = place;

            return MediaUploadButtonWidget(
              hintText: context.language.selectAlertLocation,
              text: place,
              icon: Icons.my_location_outlined,
              onTap: () {
                /*hideAppKeyboard(context);
                _showLocationView(context);*/
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

    final selectedLatLng = ctx.read<AlertAddProvider>().selectedLatLng;

    final center = selectedLatLng ?? ctx.lastSavedLocationLatLng;

    ctx.read<AlertAddProvider>().scaffoldKey.currentState?.showBottomSheet(
          shape: const RoundedRectangleBorder(),
          backgroundColor: Colors.black38,
          enableDrag: false,
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(ctx).height),
          (context) => LocationBottomSheetView(
            center: center,
            onConfirm: (latLng) {
              context.read<AlertAddProvider>().selectedLatLng = latLng;
              context.pop();
            },
          ),
        );

    // FIXME: remove scaffold key from provider, use context based bottom sheet
    // showBottomSheet(context: ctx,
    //     shape: const RoundedRectangleBorder(),
    //     backgroundColor: Colors.black38,
    //     enableDrag: false,
    //     constraints: BoxConstraints(maxHeight: height),
    //
    //     builder: (cooo){
    //   return LocationBottomSheetView(
    //     center: center,
    //     onConfirm: (latLng) {
    //       cooo.read<AlertAddProvider>().selectedLatLng = latLng;
    //       cooo.pop();
    //     },
    //   );
    // });
  }
}
