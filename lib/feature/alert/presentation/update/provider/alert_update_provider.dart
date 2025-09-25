import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/feature/alert/domain/usecase/alert_update_use_case.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/utils/resource/dependency_injection.dart';
import '../../../domain/entity/alert_entity.dart';

class AlertUpdateProvider extends BaseProvider {
  final AlertEntity alertModel;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AlertUpdateProvider(this.alertModel) {
    _selectedLatLng = LatLng(alertModel.latitude, alertModel.longitude);
    description = alertModel.description;
    detailAddress = alertModel.address;
    geoAddress = alertModel.geoAddress;
  }

  late LatLng _selectedLatLng;

  LatLng get selectedLatLng => _selectedLatLng;

  set selectedLatLng(LatLng value) {
    _selectedLatLng = value;
    notify();
  }

  String? geoAddress;

  String? description;
  String? detailAddress;

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    description = null;
    detailAddress = null;
    geoAddress = null;
    _selectedLatLng = LatLng(alertModel.latitude, alertModel.longitude);
  }

  bool isAlertUpdating = false;

  Future<bool> updateAlert({required int userId, required String token}) async {
    if (description == null || description!.trim().isEmpty) {
      return Future.error('Please enter description');
    }

    isAlertUpdating = true;
    notify();
    final updateAlertUseCase = getIt<AlertUpdateUseCase>();
    final param = AlertUpdateParam(
        token: token,
        userId: userId,
        alertId: alertModel.id,
        description: description!,
        detailAddress: detailAddress,
        geoAddress: geoAddress,
        latitude: selectedLatLng.latitude,
        longitude: selectedLatLng.longitude);
    final result = await updateAlertUseCase(param);
    isAlertUpdating = false;
    notify();

    return result.fold((l) => Future.error(l.message), (r) => r);
  }
}
