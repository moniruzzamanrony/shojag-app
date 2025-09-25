/*
* ui : profile update/edit page
*/

import 'package:app/core/utils/enums/user_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/profile/presentation/page/edit/citizen_edit_form.dart';
import 'package:app/feature/profile/presentation/page/edit/police_edit_form.dart';
import 'package:app/shared/domain/entity/session_auth_entity.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/style/style.dart';
import '../../../../../shared/presentation/widget/custom_app_bar.dart';
import '../../../../../shared/presentation/widget/error_text_widget.dart';
import '../../provider/profile_edit_provider.dart';
import 'ambulance_edit_form.dart';
import 'fire_service_edit_form.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Column(
        children: [
          CustomAppBar(title: context.language.editProfile),
          Expanded(
            child: CurvedBottomBackground(
              child: CurvedTopRadiusToChild(
                child: SingleChildScrollView(
                  padding: Styles.horizontalPadding,
                  child: Column(
                    children: [
                      32.gapH,
                      _profileForm(context),
                      profileEditItemGap(),
                      Selector<ProfileEditProvider, String?>(
                        selector: (_, provider) => provider.errorMessage,
                        builder: (_, errorText, __) =>
                            ErrorTextWidget(errorText: errorText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileForm(BuildContext ctx) {
    final userType = ctx.userType;
    switch (userType) {
      case UserType.citizen:
        return CitizenEditForm(currentUser: ctx.user as UserCitizen);
      case UserType.police:
        return PoliceEditForm(currentUser: ctx.user as UserPolice);
      case UserType.fireService:
        return FireServiceEditForm(currentUser: ctx.user as UserFireService);
      case UserType.ambulance:
        return AmbulanceEditForm(currentUser: ctx.user as UserAmbulance);
      default:
        return const SizedBox.shrink();
    }
  }
}

Gap profileEditItemGap() => 16.gapH;
