/*
* ui : alert map page
*/

import 'package:app/feature/alert_map/presentation/widget/all_active_alert_view_map_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';

class AlertMapPage extends StatefulWidget {
  const AlertMapPage({super.key});

  @override
  State<AlertMapPage> createState() => _AlertMapPageState();
}

class _AlertMapPageState extends State<AlertMapPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CurvedTopRadiusToChild(child: AllActiveAlertViewMapWidget());
  }

  @override
  bool get wantKeepAlive => true;
}
