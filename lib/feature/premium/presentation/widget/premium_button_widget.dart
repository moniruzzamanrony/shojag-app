import 'package:app/core/utils/constants/assets.dart';
import 'package:app/feature/premium/presentation/widget/upgrade_to_premium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/premium_entity.dart';
import '../provider/premium_provider.dart';

class PremiumButtonWidget extends StatelessWidget {
  final Widget child;
  final double? size;

  const PremiumButtonWidget({super.key, required this.child, this.size});

  @override
  Widget build(BuildContext context) {
    return Selector<PremiumProvider, PremiumEntity>(
        selector: (_, provider) => provider.premiumEntity,
        builder: (_, model, __) {
          if (model.isValidPremiumUser) {
            return child;
          }
          final size = this.size ?? 10.r;
          return InkWell(
            onTap: () => showPremiumBottomSheet(context),
            child: CircleAvatar(
              radius: size,
              backgroundColor: Colors.amber.shade100,
              child: SvgPicture.asset(
                Assets.premiumCrownSvg,
                height: size,
                width: size,
              ),
            ),
          );
        });
  }
}
