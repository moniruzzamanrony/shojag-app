import 'dart:io';

import 'package:app/feature/alert/data/model/create/alert_add_remote_post_model.dart';
import 'package:app/feature/alert/domain/repository/alert_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/usecase/usecase.dart';

class AlertAddRemoteUseCase implements UseCase<bool, AlertAddRemoteParam> {
  final AlertRepository repository;

  const AlertAddRemoteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AlertAddRemoteParam params) async {
    MultipartFile? image;

    if (params.image != null) {
      image = await MultipartFile.fromFile(params.image!.path);
    }

    final response = await repository.addAlertRemote(
        token: params.token,
        model: AlertAddRemotePostModel(
          userId: params.userId,
          categoryIds: params.categoryIds,
          incidentId: params.incidentId,
          customIncident: params.customIncident,
          description: params.description,
          latitude: params.latitude,
          longitude: params.longitude,
          address: params.address,
          geoAddress: params.geoAddress,
          image: image,
        ));
    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.success == true) {
          return const Right(true);
        }
        return Left(ServerFailure(r.message ?? ''));
      },
    );
  }
}

class AlertAddRemoteParam {
  final String token;
  final int userId;
  final String categoryIds;
  final int? incidentId;
  final String? customIncident;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final String? geoAddress;
  final File? image;

  const AlertAddRemoteParam({
    required this.token,
    required this.userId,
    required this.categoryIds,
    this.incidentId,
    this.customIncident,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.geoAddress,
    required this.image,
  });
}
