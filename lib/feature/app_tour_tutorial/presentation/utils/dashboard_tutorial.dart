import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/feature/app_tour_tutorial/presentation/utils/tutorial_data.dart';
import 'package:app/feature/app_tour_tutorial/presentation/widget/tutorial_skip_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../provider/app_tour_provider.dart';
import '../widget/tutorial_content_widget.dart';

TutorialCoachMark? _tutorialCoachMark;

TutorialCoachMark? get tutorialCoachMark => _tutorialCoachMark;


void createTutorial(BuildContext context) {
  _tutorialCoachMark ??= TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: AppColors.colorAppGreen,
      paddingFocus: 0,
      skipWidget: const TutorialSkipWidget(),
      onFinish: () {
        if (!context.mounted) return;
        context.read<AppTourProvider>().saveAppTourViewStatus(status: true);
      },
      onSkip: () {
        if (!context.mounted) return true;
        context.read<AppTourProvider>().saveAppTourViewStatus(status: true);
        return true;
      },
      opacityShadow: 0.95);
}

List<TargetFocus> _createTargets() {
  List<TargetFocus> targets = [];
  for (final entries in TutorialKeys.keys.entries) {
    final key = entries.key;
    final targetKey = entries.value;
    final model = dashboardTutorialData[key];
    if (model == null) continue;
    targets.add(
      TargetFocus(
        identify: key,
        keyTarget: targetKey,
        alignSkip: Alignment.topCenter,
        enableTargetTab: false,
        contents: [
          TargetContent(
            align: model.contentAlign,
            builder: (_, __) {
              return TutorialContentWidget(model: model);
            },
          ),
        ],
      ),
    );
  }
  return targets;
}