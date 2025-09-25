import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/app_tour_tutorial/presentation/utils/tutorial_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/theme/app_colors.dart';

class TutorialContentWidget extends StatelessWidget {
  final TutorialDataModel model;

  const TutorialContentWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final title = context.isBangla ? model.titleBn : model.titleEn;
    final features = context.isBangla ? model.featuresBn : model.featuresEn;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorBlack.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.colorWhite.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
              color: AppColors.colorWhite.withValues(alpha: 0.20),
              blurRadius: 20,
              blurStyle: BlurStyle.outer
              //offset: const Offset(0, 10),
              ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.w800,
              color: AppColors.colorWhite,
            ),
          ),
          const SizedBox(height: 14),
          ...features.map((feature) => _buildFeatureTile(feature)),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(String feature) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: [
            AppColors.colorWhite.withValues(alpha: 0.2),
            AppColors.colorAppGreen.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.colorWhite.withValues(alpha: 0.2),
                  AppColors.colorAppGreen.withValues(alpha: 0.8),
                ],
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: const FaIcon(
              FontAwesomeIcons.check,
              size: 14,
              color: AppColors.colorWhite,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w500,
                color: AppColors.colorWhite,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
