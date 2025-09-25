import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/utils/style/style.dart';
import '../provider/premium_provider.dart';

void showPremiumUpgradePopup(BuildContext context) async {
  if (!context.mounted) return;
  if (!context.isCitizen) return;
  final premiumProvider = Provider.of<PremiumProvider>(context, listen: false);

  if (premiumProvider.premiumEntity.isValidPremiumUser) return;

  if (premiumProvider.premiumPopupViewDate.isSameDay(other: DateTime.now())) {
    return;
  }

  showAppDialog(
    context,
    dialogWidget: const PremiumUpgradePopup(),
  );
  await premiumProvider.savePremiumPopupViewDate();
}

class PremiumUpgradePopup extends StatelessWidget {
  const PremiumUpgradePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.primaryContainer;
    final cardColor = color.shade(240);
    final onCardColor = cardColor.determineTextColor;
    return Dialog(
      backgroundColor: cardColor,
      insetPadding: EdgeInsets.all(20.r),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SimpleLottie(Assets.proSubscriptionAnimationJson),
                Text(
                  context.language.youAreNotAPremiumUser,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Dimens.fontSize14, color: onCardColor),
                ),
                Gap(Dimens.padding16),
                FilledButton(
                    onPressed: () {
                      context.pop();
                      context.goNamed(Routes.premiumPackageSelection);
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: color,
                        visualDensity: Styles.minimumVisualDensity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 20.h)),
                    child: Text(
                      context.language.upgradeNow,
                    )),
                Gap(Dimens.padding20),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: context.colorScheme.error.shade(240)),
                icon: Icon(
                  Icons.close,
                  color: context.colorScheme.error,
                  size: Dimens.iconSize20,
                ),
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
