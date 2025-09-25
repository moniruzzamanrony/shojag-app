import 'dart:io';

import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/resource/dependency_injection.dart';
import 'package:app/feature/alert/domain/entity/incident_type_view_model.dart';
import 'package:app/feature/alert/domain/usecase/alert_add_remote_use_case.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

/// Provider for the alert add page
/// It is used to manage the state of the alert add page
/// and to handle the logic of the alert add
class AlertAddProvider extends BaseProvider {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  IncidentTypeViewModel? selectedIncidentType;
  String? customIncident;

  void updateSelectedType(IncidentTypeViewModel? type) {
    selectedIncidentType = type;
    notify();
  }

  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  set selectedImage(File? value) {
    _selectedImage = value;
    notify();
  }

  XFile? _selectedVideo;

  XFile? get selectedVideo => _selectedVideo;

  set selectedVideo(XFile? value) {
    _selectedVideo = value;
    notify();
  }

  String? description;
  String? detailAddress;
  String? geoAddress;
  LatLng? _selectedLatLng;

  LatLng? get selectedLatLng => _selectedLatLng;

  set selectedLatLng(LatLng? value) {
    _selectedLatLng = value;
    notify();
  }

  Map<AlertType, AlertType> selectedMoreAlertType = {};

  void toggleSelectedAlertType(AlertType type) {
    final temp = Map<AlertType, AlertType>.from(selectedMoreAlertType);
    if (temp.containsKey(type)) {
      temp.remove(type);
    } else {
      temp[type] = type;
    }
    selectedMoreAlertType = temp;
    notify();
  }

  bool isAlertAdding = false;

  Future<bool> addAlert(
      {required int userId,
      required String token,
      required AlertType selectedPrimaryCategory}) async {
    if (isAlertAdding) return false;
    if (selectedPrimaryCategory == AlertType.ambulance) {
      customIncident = 'Ambulance Alert';
    } else if (selectedPrimaryCategory == AlertType.police) {
      customIncident = 'Police Alert';
    }

    isAlertAdding = true;
    notify();

    final categories = selectedMoreAlertType.values.map((e) => e.id).toList()
      ..add(selectedPrimaryCategory.id);
    final categoriesAsString = categories.join(',');

    final addAlertUseCase = getIt<AlertAddRemoteUseCase>();
    final param = AlertAddRemoteParam(
      token: token,
      userId: userId,
      categoryIds: categoriesAsString,
      incidentId: selectedIncidentType?.id,
      customIncident: customIncident,
      description: description!,
      latitude: _selectedLatLng!.latitude,
      longitude: _selectedLatLng!.longitude,
      address: detailAddress ?? '',
      geoAddress: geoAddress,
      image: _selectedImage,
    );
    final response = await addAlertUseCase(param);
    isAlertAdding = false;
    notify();
    return response.fold((l) => Future.error(l.message), (r) => r);
  }

  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {
    selectedMoreAlertType = {};
    selectedIncidentType = null;
    customIncident = null;
    _selectedImage = null;
    _selectedVideo = null;
    description = null;
    _selectedLatLng = null;
    detailAddress = null;
    isAlertAdding = false;
  }
}
