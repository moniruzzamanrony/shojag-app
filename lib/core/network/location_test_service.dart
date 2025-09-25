import 'package:app/core/network/base_api_service.dart';
import 'package:logger/logger.dart';

class LocationTestService {
  Future<Map<String, dynamic>?> getLocations() async {
    BaseApiService apiService = BaseApiService();
    final result = await apiService.get(
        token: '',
        endPoint: '/api/testlocation',
        fromJson: (data) => data,
        useIsolate: false);

    return result.fold((l) => null, (r) => r);
  }

  Future<Map<String, dynamic>?> uploadLocation(
      {required double latitude,
      required double longitude,
      String message = ''}) async {
    BaseApiService apiService = BaseApiService();
    final result = await apiService.post(
        token: '',
        endPoint: '/api/testlocation',
        fromJson: (data) => data,
        data: {
          'latitude': latitude,
          'longitude': longitude,
          'time': DateTime.now().toIso8601String(),
          'message': message
        });

    Logger().d('message');
    return result.fold((l) => null, (r) => r);
  }

  Future<Map<String, dynamic>?> deleteLocation(int id) async {
    BaseApiService apiService = BaseApiService();
    final result = await apiService.delete(
      token: '',
      endPoint: '/api/testlocation/$id',
      fromJson: (data) => data,
    );
    return result.fold((l) => null, (r) => r);
  }
}
