import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/utils/constants/dimens.dart';
import '../../domain/entity/premium_entity.dart';

class PremiumPackageInfoWidget extends StatelessWidget {
  const PremiumPackageInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<PremiumProvider, PremiumEntity>(
      selector: (_, provider) => provider.premiumEntity,
      builder: (_, entity, __) {
        return entity.isValidPremiumUser
            ? _premiumUserView(context, entity)
            : _nonPremiumUserView(context);
      },
    );
  }

  // ui for premium user view
  Widget _premiumUserView(BuildContext context, PremiumEntity entity) {
    final premiumEntity = context.read<PremiumProvider>().premiumEntity;
    final expiryDate = premiumEntity.expireDate;
    final startDate = expiryDate.subtract(const Duration(days: 30));
    final daysLeft = expiryDate.difference(DateTime.now()).inDays;
    final totalDays = expiryDate.difference(startDate).inDays;
    final remainingDaysProgress = (daysLeft / totalDays).clamp(0.0, 1.0);
    final primaryColor = context.colorScheme.primary;
    final onColor = context.colorScheme.onPrimary;

    return InkWell(
      onTap: () {
        if (premiumEntity.isValidPremiumUser) {
          context.goNamed(Routes.subscriptionHome);
        } else {
          context.goNamed(Routes.premiumPackageSelection);
        }
      },
      child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
              color: context.colorScheme.primary.shade(240),
              borderRadius: BorderRadius.circular(Dimens.borderRadius10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    context.language.yourCurrentSubscription,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.0),
                  ),
                  4.gapW,
                  _pro(primaryColor, onColor, context),
                ],
              ),
              Gap(Dimens.padding10),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(Dimens.borderRadius6),
                value: remainingDaysProgress,
                minHeight: Dimens.padding6,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              Gap(Dimens.padding4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(context.language.daysLeft(daysLeft),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      )),
                ],
              ),
            ],
          )),
    );

    // final color = AppColors.colorAppGreen;
    // final onColor = AppColors.colorWhite;
    // final cardColor = color.shade(240);

    // return Container(
    //   width: double.infinity,
    //   padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
    //   decoration: BoxDecoration(
    //       color: cardColor, borderRadius: BorderRadius.circular(6.r)),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             context.language.yourCurrentSubscription,
    //             style: TextStyle(
    //                 fontSize: 12.sp, fontWeight: FontWeight.w500, height: 1.0),
    //           ),
    //           4.gapW,
    //           _pro(color, onColor, context),
    //         ],
    //       ),
    //       6.gapH,
    //       Text(
    //         context.language.yourSubscriptionWillBeExpireOnWithDate(
    //                 entity.expireDate.formatDate(pattern: pattern_ddMMMyyyy)),
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontSize: 11.sp,
    //             fontWeight: FontWeight.w500,
    //             height: 1.0,
    //             color: color),
    //       ),
    //     ],
    //   ),
    // );
  }

  // pro user chip label ui
  Container _pro(Color color, Color onColor, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.workspace_premium,
            color: onColor,
            size: 14.sp,
          ),
          4.gapW,
          Text(
            context.language.pro,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                height: 1.0,
                color: onColor),
          ),
        ],
      ),
    );
  }

  // ui for non premium user
  Widget _nonPremiumUserView(BuildContext context) {
    final color = const Color(0xFFE1A732);
    //final onColor = AppColors.colorWhite;
    final cardColor = color.shade(240);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(6.r)),
      child: Column(
        children: [
          Text(
            context.language.youAreNotAPremiumUser,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: color),
          ),
          6.gapH,
          FilledButton(
              onPressed: () {
                context.goNamed(Routes.premiumPackageSelection);
              },
              style: FilledButton.styleFrom(
                  backgroundColor: color,
                  visualDensity: Styles.minimumVisualDensity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h)),
              child: Text(
                context.language.upgradeNow,
              )),
        ],
      ),
    );
  }
}
