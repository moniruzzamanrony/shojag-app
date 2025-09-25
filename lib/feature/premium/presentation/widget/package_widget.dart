import 'package:app/core/config/router/routes.dart';
import 'package:app/core/utils/constants/api_constants.dart';
import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/colored_background_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/style/style.dart';
import '../../../fnf/presentation/list/provider/fnf_list_provider.dart';
import '../provider/subsription_provider.dart';

class PackageWidget extends ConsumerStatefulWidget {
  const PackageWidget({super.key});

  @override
  ConsumerState<PackageWidget> createState() => _PackageWidgetState();
}

class _PackageWidgetState extends ConsumerState<PackageWidget> {
  //late SubscriptionProvider subscriptionProvider;

  @override
  void initState() {
    super.initState();

    // subscriptionProvider =
    //     Provider.of<SubscriptionProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final package = ref.read(subscriptionProvider);
    return CurvedBottomBackground(
      child: Padding(
        padding: Styles.horVerPadding,
        child: Column(
          children: [
            SvgPicture.asset(
              Assets.premiumCrownSvg,
              height: 100.h,
            ),
            16.gapH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.language.upgrade,
                  style: TextStyle(
                    fontSize: 20.sp,
                    height: 1.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                8.gapW,
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Text(
                    context.language.pro,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        height: 1.0,
                        color: context.colorScheme.onPrimary),
                  ),
                )
              ],
            ),
            8.gapH,
            Text(
              context.language.pleaseUpgradeToProToUnlockAllFeatures,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: AppColors.colorAppGrey),
            ),
            16.gapH,
            _buildFeatures(
                context: context,
                title: context.language.addFnf,
                subtitle: context.language.youCanAddUnlimitedFnfWithPremiumUser,
                leadingIcon: FontAwesomeIcons.peopleGroup),
            _buildFeatures(
                context: context,
                title: context.language.locateYourFnf,
                subtitle: context.language.locateYourFnfLiveLocation,
                leadingIcon: FontAwesomeIcons.locationDot),
            _buildFeatures(
                context: context,
                title: context.language.addCustomLocation,
                subtitle: context.language.youCanAddUpToAddressWithCount(
                    AppConstants.maxFnfAddressLocationCount),
                leadingIcon: FontAwesomeIcons.solidFlag),
            16.gapH,
            ColoredBackgroundButton(
              buttonColor: ColoredButtonType.green,
              onPressed: () => _payNow(package.amount),
              text: context.language.unlockProWithCurrencyAndAmountAndDays(
                  context.isBangla
                      ? AppConstants.currencySymbolBn
                      : AppConstants.currencySymbolEn,
                  package.amount,
                  package.days),
            )
          ],
        ),
      ),
    );
  }

  ListTile _buildFeatures(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required IconData leadingIcon}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.top,
      leading: CircleAvatar(child: FaIcon(leadingIcon, size: 16.sp)),
      title: Text(title),
      titleTextStyle: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
      subtitle: Text(subtitle),
      subtitleTextStyle: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
    );
  }

  // pay through ssl commerz gateway
  void _payNow(double amount) async {
    final userId = context.userId;
    final apiToken = context.apiToken;
    final premiumProvider = context.read<PremiumProvider>();
    final transactionId = '$userId-${DateTime.now().millisecondsSinceEpoch}';

    const storeId =
        String.fromEnvironment(AppConstants.sslcommerzStoreIdEnvKey);
    const storePassword =
        String.fromEnvironment(AppConstants.sslcommerzStorePasswordEnvKey);

    final sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
            ipn_url: ApiConstants.paymentIpnUrl,
            currency: SSLCurrencyType.BDT,
            product_category: "Digital Service",
            sdkType: SSLCSdkType.LIVE,
            store_id: storeId,
            store_passwd: storePassword,
            total_amount: amount,
            tran_id: transactionId));

    // final sslcommerz = Sslcommerz(
    //     initializer: SSLCommerzInitialization(
    //         ipn_url: ApiConstants.paymentIpnUrl,
    //         currency: SSLCurrencyType.BDT,
    //         product_category: "Digital Product",
    //         sdkType: SSLCSdkType.TESTBOX,
    //         store_id: "testc677652f687962",
    //         store_passwd: "testc677652f687962@ssl",
    //         total_amount: 11,
    //         tran_id: DateTime.now().millisecondsSinceEpoch.toString()));

    sslcommerz.addAdditionalInitializer(
        sslcAdditionalInitializer:
            SSLCAdditionalInitializer(valueA: '$userId'));

    try {
      final response = await sslcommerz.payNow();

      if (response.status == 'VALID') {
        await premiumProvider.checkAndUpdatePremiumService(
            userId: userId, apiToken: apiToken);
        if (!mounted) {
          return;
        }
        if (premiumProvider.premiumEntity.isValidPremiumUser) {
          ref.read(fnfListProvider.notifier).loadList(
                token: context.apiToken,
                userId: context.userId,
              );

          // go to dashboard
          context.goNamed(Routes.dashboard);
        }
        return;
      } else if (response.status == 'FAILED') {
      } else if (response.status == 'CANCELLED') {
      } else if (response.status == 'UNATTEMPTED') {
      } else if (response.status == 'EXPIRED') {}

      //log(jsonEncode(response.toJson()));
    } catch (e) {
      //print(e.toString());
    }
  }
}
