/*
* ui: home page
*/

import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/alert_type.dart';
import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/app_tour_tutorial/presentation/utils/tutorial_data.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/assets.dart';
import '../../../../core/utils/style/style.dart';
import '../widget/home_button_widget.dart';
import '../widget/recent_section_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return context.userType == UserType.citizen
        ? _communitySection(context)
        : _otherSection(context);
  }

  // home ui for other [UserType.police, UserType.fireService, UserType.ambulance]
  Widget _otherSection(BuildContext context) {
    return CurvedTopRadiusToChild(
      padding: EdgeInsets.only(top: Dimens.padding8),
      child: const RecentSectionWidget(),
    );
  }

  // home ui for [UserType.citizen]
  Widget _communitySection(BuildContext context) {
    return Column(
      spacing: Dimens.padding8,
      children: [
        _buttonSection(context),
        const Expanded(child: RecentSectionWidget()),
      ],
    );
  }

  // create new alert button section widget
  Widget _buttonSection(BuildContext context) {
    return Card(
      margin: Styles.horizontalPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.borderRadius10),
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding12),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                    child: DottedLine(dashColor: AppColors.colorGreyLight)),
                Gap(Dimens.padding4),
                Text(context.language.createAlert,
                    style: TextStyle(
                        fontSize: 12.sp, color: AppColors.colorAppGrey)),
                Gap(Dimens.padding4),
                const Expanded(
                    child: DottedLine(dashColor: AppColors.colorGreyLight)),
              ],
            ),
            Gap(Dimens.padding8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Dimens.padding6,
              children: [
                Expanded(
                    child: HomeButtonWidget(
                  key: TutorialKeys.communityButtonKey,
                  backgroundColor: AppColors.communityCardColor,
                  borderColor: AppColors.communityCardBorderColor,
                  icon: Assets.citizenSvg,
                  buttonText: context.language.community,
                  buttonType: AlertType.community,
                )),
                Expanded(
                    child: HomeButtonWidget(
                  key: TutorialKeys.policeButtonKey,
                  backgroundColor: AppColors.policeCardColor,
                  borderColor: AppColors.policeCardBorderColor,
                  icon: Assets.policeSvg,
                  buttonText: context.language.police,
                  buttonType: AlertType.police,
                )),
                Expanded(
                    child: HomeButtonWidget(
                  key: TutorialKeys.fireServiceButtonKey,
                  backgroundColor: AppColors.fireServiceCardColor,
                  borderColor: AppColors.fireServiceCardBorderColor,
                  icon: Assets.fireServiceSvg,
                  buttonText: context.language.fire_service,
                  buttonType: AlertType.fireService,
                )),
                Expanded(
                    child: HomeButtonWidget(
                  key: TutorialKeys.ambulanceButtonKey,
                  backgroundColor: AppColors.ambulanceCardColor,
                  borderColor: AppColors.ambulanceCardBorderColor,
                  icon: Assets.ambulanceSvg,
                  buttonText: context.language.ambulance,
                  buttonType: AlertType.ambulance,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
