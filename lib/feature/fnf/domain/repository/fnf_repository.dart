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
import 'package:app/feature/fnf/data/model/request/accept_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/request/accept_fnf_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/request/send_request_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/request/send_request_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_response_model.dart';
import 'package:app/feature/fnf/data/service/fnf_remote_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/message/fnf_message_remote_post_model.dart';
import '../../data/model/message/fnf_message_remote_response_model.dart';

abstract class FnfRepository {
  final FnfRemoteService remoteService;

  const FnfRepository({required this.remoteService});


  Future<Either<Failure, SearchFnfRemoteResponseModel>> searchFnfRemote(
      {required String token, required SearchFnfRemotePostModel model});

  Future<Either<Failure, SendRequestRemoteResponseModel>> sendFnfRequestRemote(
      {required String token, required SendRequestRemotePostModel model});

  Future<Either<Failure, DeleteFnfRemoteResponseModel>> deleteFnfRemote(
      {required String token, required DeleteFnfRemotePostModel model});

  Future<Either<Failure, AcceptFnfRemoteResponseModel>> acceptFnfRequestRemote(
      {required String token, required AcceptFnfRemotePostModel model});

  Future<Either<Failure, FnfListRemoteResponseModel>> fnfListRemote(
      {required String token, required FnfListRemotePostModel model});

  Future<Either<Failure, FnfDetailsRemoteResponseModel>> fnfDetailsRemote(
      {required String token, required FnfDetailsRemotePostModel model});


  Future<Either<Failure, LocationShareLimitRemoteResponseModel>>
  locationShareTimeLimitRemote(
      {required String token,
        required LocationShareLimitRemotePostModel model});

  Future<Either<Failure, LocationShareRequestRemoteResponseModel>>
  locationShareRequestRemote(
      {required String token,
        required LocationShareRequestRemotePostModel model});

  Future<Either<Failure, FnfLocationAddRemoteResponseModel>>
  addFnfAddressRemote(
      {required String token,
        required FnfLocationAddRemotePostModel model});

  Future<Either<Failure, FnfLocationDeleteRemoteResponseModel>>
  deleteFnfAddressRemote(
      {required String token,
        required FnfLocationDeleteRemotePostModel model});

  Future<Either<Failure, FnfMessageRemoteResponseModel>> updateFnfMessage(
      {required String token, required FnfMessageRemotePostModel model});

}