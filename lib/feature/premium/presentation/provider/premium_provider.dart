import 'package:app/core/config/provider/base_provider.dart';
import 'package:app/feature/premium/domain/entity/premium_entity.dart';
import 'package:app/shared/domain/usecase/premium_popup_view_date_clear_use_case.dart';
import 'package:app/shared/domain/usecase/premium_popup_view_date_get_use_case.dart';
import 'package:app/shared/domain/usecase/premium_popup_view_date_save_use_case.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/resource/dependency_injection.dart';
import '../../domain/usecse/premium_service_check_use_case.dart';
import '../../domain/usecse/premium_service_clear_use_case.dart';
import '../../domain/usecse/premium_service_get_use_case.dart';
import '../../domain/usecse/premium_service_save_use_case.dart';

class PremiumProvider extends BaseProvider {
  @override
  void notify() => notifyListeners();

  @override
  void resetAll() {}

  PremiumEntity _premiumEntity = PremiumEntity.empty();

  PremiumEntity get premiumEntity => _premiumEntity;

  void _populatePremiumInfo() {
    final getPremiumInfo = getIt<PremiumServiceGetUseCase>();
    final result = getPremiumInfo.call(NoParams());
    _premiumEntity = result.fold((l) => PremiumEntity.empty(), (r) => r);
  }

  Future<void> savePremiumInfo(
      {required bool isPremium,
      required DateTime expireDate,
      required String currentPackage}) async {
    final savePremiumInfo = getIt<PremiumServiceSaveUseCase>();
    await savePremiumInfo.call(PremiumServiceSaveParams(
        isPremium: isPremium,
        expireDate: expireDate,
        currentPackage: currentPackage));
    _populatePremiumInfo();
  }

  Future<void> updatePremiumInfoAndNotify(
      {required bool isPremium,
      required DateTime expireDate,
      required String currentPackage}) async {
    if (_premiumEntity.isPremium != isPremium) {
      await savePremiumInfo(
          isPremium: isPremium,
          expireDate: expireDate,
          currentPackage: currentPackage);
      notify();
    }
  }

  Future<void> clearPremiumInfo() async {
    final clearPremiumInfo = getIt<PremiumServiceClearUseCase>();
    await clearPremiumInfo.call(NoParams());
    _populatePremiumInfo();
  }

  Future<void> checkAndUpdatePremiumService(
      {required int userId, required String apiToken}) async {
    final checkPremiumService = getIt<PremiumServiceCheckUseCase>();
    final param = PremiumServiceCheckParams(token: apiToken, userId: userId);
    final result = await checkPremiumService(param);
    await result.fold((l) {}, (r) async {
      await savePremiumInfo(
          isPremium: r.isPremium,
          expireDate: r.expireDate,
          currentPackage: r.currentPackage);
      notify();
    });
  }

/*  Future<void> notifyUserPremiumExpiration() async {
    print('calling nto');
    final id = 7071;
    final title = 'Shojag PRO is about to expire';
    final body =
        'Your subscription is about to expire at ${_premiumEntity.expireDate.formatDate(pattern: pattern_ddMMMyyyy)}';
    // final dateTime =
    //     _premiumEntity.expireDate.subtract(const Duration(hours: 24));
    final dateTime = DateTime.now().add(const Duration(minutes: 16));
    await LocalNotificationManager.instance
        .showScheduledNotification(id, title, body, dateTime: dateTime);
    // LocalNotificationManager.instance
    //     .showNotification(id, title, body,);
  }*/

  DateTime premiumPopupViewDate = DateTime(1970);

  Future<void> savePremiumPopupViewDate() async {
    final savePremiumPopupViewDate = getIt<PremiumPopupViewDateSaveUseCase>();
    await savePremiumPopupViewDate
        .call(PremiumPopupViewDateSaveParams(dateTime: DateTime.now()));
    _populatePremiumPopupViewDate();
  }

  Future<void> clearPremiumPopupViewDate() async {
    final clearPremiumPopupViewDate = getIt<PremiumPopupViewDateClearUseCase>();
    await clearPremiumPopupViewDate.call(NoParams());
    _populatePremiumPopupViewDate();
  }

  void _populatePremiumPopupViewDate() {
    final getPremiumPopupViewDate = getIt<PremiumPopupViewDateGetUseCase>();
    final result = getPremiumPopupViewDate.call(NoParams());
    premiumPopupViewDate = result.fold((l) => DateTime(1970), (r) => r);
  }

  PremiumProvider() {
    _populatePremiumPopupViewDate();
    _populatePremiumInfo();
    //notifyUserPremiumExpiration();
  }
}
