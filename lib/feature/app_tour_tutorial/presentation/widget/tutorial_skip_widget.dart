import 'package:app/core/utils/extension/context_extension.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/dimens.dart';
import '../utils/dashboard_tutorial.dart';

class TutorialSkipWidget extends StatefulWidget {
  const TutorialSkipWidget({super.key});

  @override
  State<TutorialSkipWidget> createState() => _TutorialSkipWidgetState();
}

class _TutorialSkipWidgetState extends State<TutorialSkipWidget> {
  late final ValueNotifier<bool> _isLastNotifier;
  late int _tutorialIndex;

  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _isLastNotifier = ValueNotifier(false);
    _tutorialIndex = 0;
  }

  @override
  void dispose() {
    _tutorialIndex = 0;
    _isLastNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = m.TextButton.styleFrom(
      foregroundColor: AppColors.colorWhite,
    );
    return Padding(
      padding: EdgeInsets.all(Dimens.horizontalSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _isLastNotifier,
            builder: (_, isLast, __) => isLast
                ? m.TextButton(
                    onPressed: () {
                      Future.microtask(() => tutorialCoachMark?.goTo(0));
                      Future.delayed(const Duration(milliseconds: 600), () {
                        _tutorialIndex = 0;
                        _isLastNotifier.value = false;
                      });
                    },
                    style: buttonStyle,
                    child: Text(context.language.tourAgain),
                  )
                : m.TextButton(
                    onPressed: () {
                      Future.microtask(() => tutorialCoachMark?.skip());
                    },
                    style: buttonStyle,
                    child: Text(context.language.skip),
                  ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isLastNotifier,
            builder: (_, isLast, __) => m.TextButton(
              onPressed: () {
                if (_isTransitioning) return;
                _isTransitioning = true;
                Future.microtask(() {
                  final totalTargets = tutorialCoachMark?.targets.length;
                  if (totalTargets == null) return;

                  _tutorialIndex++;

                  tutorialCoachMark?.next();

                  if (_tutorialIndex == totalTargets - 1) {
                    Future.delayed(const Duration(milliseconds: 600), () {
                      _isLastNotifier.value = true;
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    _isTransitioning = false;
                  });
                });
              },
              style: buttonStyle,
              child: Text(
                  isLast ? context.language.finish : context.language.next),
            ),
          ),
        ],
      ),
    );
  }
}
