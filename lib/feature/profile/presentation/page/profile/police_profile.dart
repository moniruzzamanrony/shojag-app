import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:flutter/material.dart';

import '../../widget/profile_text_widget.dart';

class PoliceProfile extends StatelessWidget {
  final UserPolice user;

  const PoliceProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        ProfileHeaderWidget(title: context.language.policeId),
        headerContentSeparator(),
        ProfileContentWidget(text: user.policeId),
        itemSeparator(),
        ProfileHeaderWidget(title: context.language.thana),
        headerContentSeparator(),
        ProfileContentWidget(text: user.thana),
        itemSeparator(),
      ],
    );
  }
}
