import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/date_time_extension.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/helper/datetime_helper.dart';
import '../../../../premium/presentation/widget/premium_package_info_widget.dart';
import '../../widget/profile_text_widget.dart';

class CitizenProfile extends StatelessWidget {
  final UserCitizen user;

  const CitizenProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PremiumPackageInfoWidget(), // only for citizen
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.name),
        headerContentSeparator(),
        ProfileContentWidget(text: user.name),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.phone),
        headerContentSeparator(),
        ProfileContentWidget(text: user.phone),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.email),
        headerContentSeparator(),
        ProfileContentWidget(text: user.email ?? 'Not set yet'),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.dateOfBirth),
        headerContentSeparator(),
        ProfileContentWidget(
            text: user.dob?.formatDate(pattern: pattern_ddMMMyyyy) ?? 'Not set yet'),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.nid),
        headerContentSeparator(),
        ProfileContentWidget(text: user.nid ?? 'Not set yet'),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.gender),
        headerContentSeparator(),
        ProfileContentWidget(text: user.gender.titleEn),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.address),
        headerContentSeparator(),
        ProfileContentWidget(text: user.address ?? 'Not set yet'),
        itemSeparator(),
      ],
    );
  }
}
