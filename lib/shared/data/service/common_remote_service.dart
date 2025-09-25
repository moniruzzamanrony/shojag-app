import '../../../../core/network/base_api_service.dart';


/// [ICommonRemoteService] is a class that provides methods to make HTTP requests to the API.
/// It handles the response and error handling.
abstract class ICommonRemoteService {
  final BaseApiService apiService;

  const ICommonRemoteService(this.apiService);
}

class CommonRemoteService extends ICommonRemoteService {
  const CommonRemoteService(super.apiService);
}
