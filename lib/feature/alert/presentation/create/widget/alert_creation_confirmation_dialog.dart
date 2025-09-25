import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/style/style.dart';

/// UI [AlertCreationConfirmationDialog] for alert creation confirmation
class AlertCreationConfirmationDialog extends StatefulWidget {
  const AlertCreationConfirmationDialog({super.key});

  @override
  State<AlertCreationConfirmationDialog> createState() =>
      _AlertCreationConfirmationDialogState();
}

class _AlertCreationConfirmationDialogState
    extends State<AlertCreationConfirmationDialog> {
  //bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: Styles.horizontalPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.gapH,
                Text(
                  context.language.confirmation,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                8.gapH,
                Text(
                  context.language.iAmSureAboutTheAlert,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
                20.gapH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          context.pop(false);
                        },
                        child: Text(context.language.cancel)),
                    8.gapW,
                    FilledButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: Text(context.language.iAmSure))
                  ],
                ),
                8.gapH,
              ],
            ),
          ),
          Positioned(
              top: -12.r,
              right: -12.r,
              child: InkWell(
                onTap: () {
                  context.pop(false);
                },
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: AppColors.colorAppRed,
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    size: 12.r,
                    color: AppColors.colorWhite,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
