import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert/presentation/update/provider/alert_update_provider.dart';
import 'package:app/feature/alert/presentation/update/widget/alert_update_button_widget.dart';
import 'package:app/feature/alert/presentation/update/widget/alert_update_location_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/style/style.dart';
import '../../create/widget/add_form_text_field.dart';

class AlertUpdatePage extends StatelessWidget {
  const AlertUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final updateProvider = context.read<AlertUpdateProvider>();
    return HomeBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      key: updateProvider.scaffoldKey,
      body: Column(
        children: [
          CustomAppBar(title: context.language.alertUpdate),
          Expanded(
              child: CurvedTopRadiusToChild(
            padding: Styles.horVerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context, context.language.alertDescription,
                    isMandatory: true),
                2.gapH,
                AddFormTextField(
                  hintText: context.language.describeYourIncident,
                  maxLines: 4,
                  initialText: updateProvider.description,
                  onChanged: (v) {
                    updateProvider.description = v;
                  },
                ),
                10.gapH,
                _header(context, context.language.location, isMandatory: true),
                2.gapH,
                const AlertUpdateLocationWidget(),
                10.gapH,
                _header(context, context.language.addressOptional),
                2.gapH,
                AddFormTextField(
                  hintText: context.language.egFlatNoRoadNo,
                  initialText: updateProvider.detailAddress,
                  onChanged: (v) {
                    updateProvider.detailAddress = v;
                  },
                ),
                20.gapH,
                const Center(child: AlertUpdateButtonWidget()),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  Widget _header(BuildContext ctx, String title, {bool isMandatory = false}) {
    final headerChild = Text(
      title,
      style: TextStyle(
          color: AppColors.colorAppGrey,
          fontSize: 10.sp,
          height: 1.2,
          fontWeight: FontWeight.w400),
    );
    return isMandatory
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            headerChild,
            4.gapW,
            Text(
              '(${ctx.language.starRequired})',
              style: TextStyle(
                  fontSize: 10.sp, height: 1.2, color: AppColors.colorAppRed),
            )
          ])
        : headerChild;
  }
}
