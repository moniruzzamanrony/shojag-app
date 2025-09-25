import 'package:app/core/error/data_state.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_add_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_add_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_delete_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_delete_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/delete/delete_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/delete/delete_fnf_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/detail/fnf_details_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/detail/fnf_details_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/list/fnf_list_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/list/fnf_list_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_limit_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_limit_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_request_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_request_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/message/fnf_message_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/message/fnf_message_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/request/accept_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/request/accept_fnf_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/request/send_request_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/request/send_request_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../fnf/domain/repository/fnf_repository.dart';

class FnfRepositoryImpl extends FnfRepository {
  const FnfRepositoryImpl({required super.remoteService});

  @override
  Future<Either<Failure, AcceptFnfRemoteResponseModel>> acceptFnfRequestRemote(
      {required String token, required AcceptFnfRemotePostModel model}) {
    return remoteService.acceptFnfRequest(token: token, model: model);
  }

  @override
  Future<Either<Failure, DeleteFnfRemoteResponseModel>> deleteFnfRemote(
      {required String token, required DeleteFnfRemotePostModel model}) {
    return remoteService.deleteFnf(token: token, model: model);
  }

  @override
  Future<Either<Failure, FnfDetailsRemoteResponseModel>> fnfDetailsRemote(
      {required String token, required FnfDetailsRemotePostModel model}) {
    return remoteService.fnfDetails(token: token, model: model);
  }

  @override
  Future<Either<Failure, FnfListRemoteResponseModel>> fnfListRemote(
      {required String token, required FnfListRemotePostModel model}) {
    return remoteService.fnfList(token: token, model: model);
  }

  @override
  Future<Either<Failure, SearchFnfRemoteResponseModel>> searchFnfRemote(
      {required String token, required SearchFnfRemotePostModel model}) {
    return remoteService.searchFnf(token: token, model: model);
  }

  @override
  Future<Either<Failure, SendRequestRemoteResponseModel>> sendFnfRequestRemote(
      {required String token, required SendRequestRemotePostModel model}) {
    return remoteService.sendFnfRequest(token: token, model: model);
  }

  @override
  Future<Either<Failure, LocationShareRequestRemoteResponseModel>>
      locationShareRequestRemote(
          {required String token,
          required LocationShareRequestRemotePostModel model}) {
    return remoteService.locationShareRequest(token: token, model: model);
  }

  @override
  Future<Either<Failure, LocationShareLimitRemoteResponseModel>>
      locationShareTimeLimitRemote(
          {required String token,
          required LocationShareLimitRemotePostModel model}) {
    return remoteService.locationShareTimeLimit(token: token, model: model);
  }

  @override
  Future<Either<Failure, FnfLocationAddRemoteResponseModel>>
      addFnfAddressRemote(
          {required String token,
          required FnfLocationAddRemotePostModel model}) {
    return remoteService.addFnfAddress(token: token, model: model);
  }

  @override
  Future<Either<Failure, FnfLocationDeleteRemoteResponseModel>>
      deleteFnfAddressRemote(
          {required String token,
          required FnfLocationDeleteRemotePostModel model}) {
    return remoteService.deleteFnfAddress(token: token, model: model);
  }

  @override
  Future<Either<Failure, FnfMessageRemoteResponseModel>> updateFnfMessage(
      {required String token, required FnfMessageRemotePostModel model}) {
    return remoteService.updateFnfMessage(token: token, model: model);
  }
}
