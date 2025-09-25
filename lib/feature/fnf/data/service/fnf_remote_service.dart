import 'package:app/core/utils/constants/api_constants.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_add_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_add_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_delete_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/address/fnf_location_delete_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_limit_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_limit_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_request_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/location/location_share_request_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/message/fnf_message_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/message/fnf_message_remote_response_model.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_post_model.dart';
import 'package:app/feature/fnf/data/model/search/search_fnf_remote_response_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../fnf/data/model/delete/delete_fnf_remote_post_model.dart';
import '../../../fnf/data/model/delete/delete_fnf_remote_response_model.dart';
import '../../../fnf/data/model/detail/fnf_details_remote_post_model.dart';
import '../../../fnf/data/model/detail/fnf_details_remote_response_model.dart';
import '../../../fnf/data/model/list/fnf_list_remote_post_model.dart';
import '../../../fnf/data/model/request/accept_fnf_remote_post_model.dart';
import '../../../fnf/data/model/request/accept_fnf_remote_response_model.dart';
import '../../../fnf/data/model/request/send_request_remote_post_model.dart';
import '../../../fnf/data/model/request/send_request_remote_response_model.dart';
import '../model/list/fnf_list_remote_response_model.dart';

abstract class IFnfRemoteService {
  final BaseApiService apiService;

  const IFnfRemoteService(this.apiService);

  Future<Either<Failure, SearchFnfRemoteResponseModel>> searchFnf({
    required String token,
    required SearchFnfRemotePostModel model,
  });

  Future<Either<Failure, SendRequestRemoteResponseModel>> sendFnfRequest({
    required String token,
    required SendRequestRemotePostModel model,
  });

  Future<Either<Failure, DeleteFnfRemoteResponseModel>> deleteFnf({
    required String token,
    required DeleteFnfRemotePostModel model,
  });

  Future<Either<Failure, AcceptFnfRemoteResponseModel>> acceptFnfRequest({
    required String token,
    required AcceptFnfRemotePostModel model,
  });

  Future<Either<Failure, FnfListRemoteResponseModel>> fnfList({
    required String token,
    required FnfListRemotePostModel model,
  });

  Future<Either<Failure, FnfDetailsRemoteResponseModel>> fnfDetails({
    required String token,
    required FnfDetailsRemotePostModel model,
  });

  Future<Either<Failure, LocationShareLimitRemoteResponseModel>> locationShareTimeLimit({
    required String token,
    required LocationShareLimitRemotePostModel model,
  });

  Future<Either<Failure, LocationShareRequestRemoteResponseModel>> locationShareRequest({
    required String token,
    required LocationShareRequestRemotePostModel model,
  });

  Future<Either<Failure, FnfLocationAddRemoteResponseModel>> addFnfAddress({
    required String token,
    required FnfLocationAddRemotePostModel model,
  });

  Future<Either<Failure, FnfLocationDeleteRemoteResponseModel>> deleteFnfAddress({
    required String token,
    required FnfLocationDeleteRemotePostModel model,
  });

  Future<Either<Failure, FnfMessageRemoteResponseModel>> updateFnfMessage({
    required String token,
    required FnfMessageRemotePostModel model,
  });
}

class FnfRemoteService extends IFnfRemoteService {
  const FnfRemoteService(super.apiService);

  @override
  Future<Either<Failure, SearchFnfRemoteResponseModel>> searchFnf({
    required String token,
    required SearchFnfRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.searchFriendEndPoint,
      data: model.toMap(),
      fromJson: SearchFnfRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, SendRequestRemoteResponseModel>> sendFnfRequest({
    required String token,
    required SendRequestRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.requestFriendEndPoint,
      data: model.toMap(),
      fromJson: SendRequestRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, DeleteFnfRemoteResponseModel>> deleteFnf({
    required String token,
    required DeleteFnfRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.deleteFriendEndPoint,
      data: model.toMap(),
      fromJson: DeleteFnfRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AcceptFnfRemoteResponseModel>> acceptFnfRequest({
    required String token,
    required AcceptFnfRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.acceptFriendRequestEndPoint,
      data: model.toMap(),
      fromJson: AcceptFnfRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, FnfListRemoteResponseModel>> fnfList({
    required String token,
    required FnfListRemotePostModel model,
  }) {
    return apiService.get(
      token: token,
      endPoint: ApiConstants.friendListEndPoint,
      query: model.toMap(),
      fromJson: FnfListRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, FnfDetailsRemoteResponseModel>> fnfDetails({
    required String token,
    required FnfDetailsRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.friendDetailEndPoint,
      data: model.toMap(),
      fromJson: FnfDetailsRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, FnfLocationAddRemoteResponseModel>> addFnfAddress({
    required String token,
    required FnfLocationAddRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.friendLocationLabelAddEndPoint,
      data: model.toMap(),
      fromJson: FnfLocationAddRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, FnfLocationDeleteRemoteResponseModel>> deleteFnfAddress({
    required String token,
    required FnfLocationDeleteRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.friendLocationLabelDeleteEndPoint,
      data: model.toMap(),
      fromJson: FnfLocationDeleteRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, LocationShareRequestRemoteResponseModel>> locationShareRequest({
    required String token,
    required LocationShareRequestRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.friendLocationShareRequestEndPoint,
      data: model.toMap(),
      fromJson: LocationShareRequestRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, LocationShareLimitRemoteResponseModel>> locationShareTimeLimit({
    required String token,
    required LocationShareLimitRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.friendLocationShareLimitEndPoint,
      data: model.toMap(),
      fromJson: LocationShareLimitRemoteResponseModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, FnfMessageRemoteResponseModel>> updateFnfMessage({
    required String token,
    required FnfMessageRemotePostModel model,
  }) {
    return apiService.post(
      token: token,
      endPoint: ApiConstants.friendMessageUpdateEndPoint,
      data: model.toMap(),
      fromJson: FnfMessageRemoteResponseModel.fromJson,
    );
  }
}
