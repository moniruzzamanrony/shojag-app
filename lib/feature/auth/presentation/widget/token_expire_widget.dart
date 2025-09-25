import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/helper/helper_functions.dart';
import 'package:app/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app/feature/premium/presentation/provider/premium_provider.dart';
import 'package:app/shared/presentation/provider/session_provider.dart';
import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/presentation/widget/logout_helper.dart';

bool _isAuthorizationChecking = false;

void checkAuthorization(BuildContext context) async {
  if (_isAuthorizationChecking) return;
  _isAuthorizationChecking = true;
  await context
      .read<AuthProvider>()
      .authorizeUser(context.apiToken)
      .catchError((error, stackTrace) {
    return null;
  }).then((entity) {
    if (entity == null) return;
    if (!context.mounted) return;

    // if token is expired then show token expire dialog
    if (entity.isTokenExpired) {
      showAppDialog(context,
          dialogWidget: const TokenExpireWidget(), barrierDismissible: false);
    } else {
      // update fcm token
      if (entity.fcmToken != null) {
        context.read<SessionProvider>().saveFcmToken(entity.fcmToken!);
      }

      // update premium info
      if (entity.isPremium != null && entity.premiumExpireAt != null) {
        context.read<PremiumProvider>().updatePremiumInfoAndNotify(
            isPremium: entity.isPremium!,
            expireDate: entity.premiumExpireAt!,
            currentPackage: '');
      }
    }
  }).whenComplete(() {
    _isAuthorizationChecking = false;
  });
}

class TokenExpireWidget extends StatelessWidget {
  const TokenExpireWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 150.h,
                  child: const SimpleLottie(Assets.secureLoginAccessJson)),
              Text(
                context.language.yourSessionHasBeenExpired,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: context.colorScheme.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                context.language.loginAgainToContinue,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.colorGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
              20.gapH,
              FilledButton(
                  onPressed: () {
                    context.pop();
                    logoutAll(context, fromRemote: false);
                  },
                  child: Text(
                    context.language.loginAgain,
                  )),
              20.gapH
            ],
          ),
        ),
      ),
    );
  }
}
