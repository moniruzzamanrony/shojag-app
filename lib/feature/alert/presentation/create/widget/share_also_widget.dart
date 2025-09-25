import 'package:app/core/utils/extension/context_extension.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/enums/alert_type.dart';
import '../provider/alert_add_provider.dart';

/// UI [ShareAlsoWidget] for share also widget
class ShareAlsoWidget extends StatelessWidget {
  final AlertType currentType;

  const ShareAlsoWidget({super.key, required this.currentType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.language.alsoShareThisAlertWith,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.colorBlack,
                  fontWeight: FontWeight.w600),
            )),
        const DottedLine(dashColor: AppColors.colorGreyLight),
        Selector<AlertAddProvider, Map<AlertType, AlertType>>(
          selector: (_, provider) => provider.selectedMoreAlertType,
          builder: (_, value, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...moreAlertTypeList.map(
                (e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: VisualDensity.comfortable,
                  title: Text(context.isBangla ? e.titleBn : e.titleEn),
                  trailing: Transform.scale(
                    alignment: Alignment.centerRight,
                    scale: 0.8,
                    child: Switch(
                      value: value.containsKey(e),
                      onChanged: (v) {
                        context
                            .read<AlertAddProvider>()
                            .toggleSelectedAlertType(e);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Returns a list of [AlertType] except the current [AlertType].
  List<AlertType> get moreAlertTypeList {
    return List.from(AlertType.list)..remove(currentType);
  }
}
