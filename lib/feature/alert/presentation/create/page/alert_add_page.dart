/* *
* ui : alert add page
* */

import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/helper/location_helper.dart';
import 'package:app/feature/alert/presentation/create/page/alert_form_fire_service.dart';
import 'package:app/feature/alert/presentation/create/provider/alert_add_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/custom_app_bar.dart';
import 'alert_form_ambulance.dart';
import 'alert_form_community.dart';
import 'alert_form_police.dart';

/// Page for adding a new alert.
/// Based on the [type], the appropriate form widget will be returned.
class AlertAddPage extends StatelessWidget {
  final AlertType type;

  const AlertAddPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // print(context.apiToken);
    //  print(context.userId);

    final alertAddProvider =
        Provider.of<AlertAddProvider>(context, listen: false);
    alertAddProvider.resetAll();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setCurrentLocation(context);
      },
    );

    return HomeBackground(
      child: Scaffold(
        key: alertAddProvider.scaffoldKey,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            CustomAppBar(
                title:
                    context.language.createAlert),
            Expanded(
                child: CurvedBottomBackground(
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: Styles.horizontalPadding,
                  child: _getForm()),
            )),
          ],
        ),
      ),
    );
  }

  /// Returns the appropriate alert form widget based on the current [AlertType].
  ///
  /// Depending on the [type], this method returns a specific form widget:
  /// - [AlertFormCommunity] for community alerts.
  /// - [AlertFormPolice] for police alerts.
  /// - [AlertFormFireService] for fire service alerts.
  /// - [AlertFormAmbulance] for ambulance alerts.
  /// - An empty widget for no alert type.
  ///
  /// Returns a [Widget] corresponding to the alert type.
  Widget _getForm() {
    switch (type) {
      case AlertType.community:
        return const AlertFormCommunity();
      case AlertType.police:
        return const AlertFormPolice();
      case AlertType.fireService:
        return const AlertFormFireService();
      case AlertType.ambulance:
        return const AlertFormAmbulance();
      case AlertType.none:
        return const SizedBox.shrink();
    }
  }

  /// Sets the current location of the user.
  void setCurrentLocation(BuildContext ctx) async {
    Position? pos;
    try {
      pos = await LocationHelper.getCurrentPosition();
      if (!ctx.mounted) {
        return;
      }

      if (pos != null) {
        ctx.read<AlertAddProvider>().selectedLatLng =
            LatLng(pos.latitude, pos.longitude);
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
