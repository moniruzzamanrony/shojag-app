import 'package:app/core/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/enums/list_type.dart';
import '../../../alert/presentation/list/provider/alert_list_provider.dart';

class RecentListSelectionButtonWidget extends StatelessWidget {
  final ListType type;
  final Color enabledColor;
  final bool isSelected;
  final String text;

  const RecentListSelectionButtonWidget(
      {super.key,
      required this.type,
      required this.enabledColor,
      required this.isSelected,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? enabledColor : AppColors.colorWhite;
    final foregroundColor = isSelected ? AppColors.colorWhite : enabledColor;

    return ElevatedButton(
      onPressed: () {
        context.read<AlertListProvider>().updateListType(type);
      },
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.symmetric(horizontal: Dimens.padding8),
        textStyle: TextStyle(fontSize: Dimens.fontSize14),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: Dimens.fontSize12),
      ),
    );
  }
}
