import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/utils/helper/datetime_helper.dart';
import '../../../../core/utils/style/style.dart';
import '../../../../shared/presentation/widget/custom_app_bar.dart';

class SubscriptionHomePage extends StatelessWidget {
  const SubscriptionHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumEntity = context.read<PremiumProvider>().premiumEntity;
    final DateTime expiryDate = premiumEntity.expireDate;
    final DateTime startDate = expiryDate.subtract(const Duration(days: 30));
    final daysLeft = expiryDate.difference(DateTime.now()).inDays;
    final totalDays = expiryDate.difference(startDate).inDays;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColorPaleMint,
      body: Column(
        children: [
          CustomAppBar(title: context.language.subscription),
          Expanded(
            child: ListView(
              padding: Styles.horizontalPadding,
              children: [
                _currentPlanCard(context, daysLeft, expiryDate),
                SizedBox(height: Dimens.padding20),
                _benefitsSection(context),
                SizedBox(height: Dimens.padding20),
                _progressBar(context, totalDays, daysLeft),
                SizedBox(height: Dimens.padding20),
                _actionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _currentPlanCard(
      BuildContext context, int daysLeft, DateTime expiryDate) {
    final primaryColor = context.colorScheme.primary;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.padding16)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.workspace_premium_rounded,
                    size: Dimens.iconSize14, color: primaryColor),
                const SizedBox(width: 10),
                Text(
                  context.language.yourCurrentSubscription,
                  style: TextStyle(
                      fontSize: Dimens.fontSize14, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(context.language.pro,
                      style: TextStyle(
                          color: Colors.white, fontSize: Dimens.fontSize12)),
                ),
              ],
            ),
            Gap(Dimens.padding6),
            Text(
              context.language
                  .expireOn(expiryDate.formatDate(pattern: pattern_ddMMMyyyy)),
              style: TextStyle(fontSize: Dimens.fontSize14, color: Colors.grey),
            ),
            Gap(Dimens.padding6),
            Text(
              context.language.remainingDays(daysLeft),
              style: TextStyle(
                  fontSize: Dimens.fontSize14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefitsSection(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.padding16)),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.language.premiumFeatures,
                style: TextStyle(
                    fontSize: Dimens.fontSize14, fontWeight: FontWeight.bold)),
            Gap(Dimens.padding10),
            _benefitRow(
                context, FontAwesomeIcons.peopleGroup, context.language.youCanAddUnlimitedFnfWithPremiumUser),
            _benefitRow(context, FontAwesomeIcons.locationDot,
                context.language.locateYourFnfLiveLocation),
            _benefitRow(context, FontAwesomeIcons.solidFlag,
                context.language.youCanAddUpToAddressWithCount(2)),
          ],
        ),
      ),
    );
  }

  Widget _benefitRow(BuildContext context, IconData icon, String text) {
    final primaryColor = context.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Icon(
              icon,
              color: primaryColor,
              size: Dimens.iconSize14,
            ),
          ),
          Gap(Dimens.padding10),
          Expanded(
              child: Text(text, textAlign: TextAlign.justify, style: TextStyle(fontSize: Dimens.fontSize14))),
        ],
      ),
    );
  }

  Widget _progressBar(BuildContext context, int totalDays, int daysLeft) {
    final primaryColor = context.colorScheme.primary;
    final remainingDaysProgress = (daysLeft / totalDays).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.language.yourSubscriptionStatus,
            style: TextStyle(
                fontSize: Dimens.fontSize14, fontWeight: FontWeight.w600)),
        Gap(Dimens.padding10),
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(Dimens.borderRadius6),
          value: remainingDaysProgress,
          minHeight: Dimens.padding10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
        Gap(Dimens.padding10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(context.language.daysLeft(daysLeft),
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _actionButtons(BuildContext context) {
    final primaryColor = context.colorScheme.primary;
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: primaryColor.determineTextColor,
            minimumSize: const Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: Icon(
            Icons.refresh,
            size: Dimens.iconSize14,
            color: primaryColor.determineTextColor,
          ),
          label: Text(context.language.renewSubscription,
              style: TextStyle(fontSize: Dimens.fontSize14)),
          onPressed: () {
            context.pushNamed(Routes.premiumPackageSelection);
          },
        ),
      ],
    );
  }
}
