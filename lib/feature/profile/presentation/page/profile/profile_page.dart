/*
* ui: profile page
*/

import 'package:animations/animations.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/profile/presentation/page/edit/profile_edit_page.dart';
import 'package:app/feature/profile/presentation/page/profile/police_profile.dart';
import 'package:app/feature/profile/presentation/provider/profile_edit_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/enums/user_type.dart';
import '../../../../../shared/domain/entity/session_auth_entity.dart';
import '../../../../../shared/presentation/widget/colored_background_button.dart';
import '../../../../../shared/presentation/widget/logout_helper.dart';
import '../../widget/profile_image_view_and_pick_widget.dart';
import 'ambulance_profile.dart';
import 'citizen_profile.dart';
import 'fire_service_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: CurvedBottomBackground(
        child: SingleChildScrollView(
          padding:
          Styles.horizontalPadding.copyWith(top: Dimens.verticalSpace, bottom: 90.h),
          child: _buildInfo(context),
        ),
      ),
    );
  }

  // build profile info
  Widget _buildInfo(BuildContext ctx) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        boxShadow: Styles.boxShadow(),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: ProfileImageViewAndPickWidget()),
          20.gapH,
          _getUserProfile(ctx),
          8.gapH,
          Row(
            children: [
              Expanded(
                  child: _ProfileEditToggle(onClosed: (p0) => setState(() {}))),
              16.gapW,
              Expanded(
                  child: ColoredBackgroundButton(
                      onPressed: () => logoutAll(ctx),
                      text: context.language.logout,
                      buttonColor: ColoredButtonType.red))
            ],
          ),
        ],
      ),
    );
  }

  // get user profile based on current user type
  Widget _getUserProfile(BuildContext context) {
    Widget child;
    final userType = context.userType;

    switch (userType) {
      case UserType.citizen:
        child = CitizenProfile(user: context.user as UserCitizen);
      case UserType.police:
        child = PoliceProfile(user: context.user as UserPolice);
      case UserType.fireService:
        child = FireServiceProfile(user: context.user as UserFireService);
      case UserType.ambulance:
        child = AmbulanceProfile(user: context.user as UserAmbulance);
      case null:
        child = const SizedBox.shrink();
      case UserType.none:
        child = const SizedBox.shrink();
    }

    return child;
  }
}

class _ProfileEditToggle extends StatelessWidget {
  final void Function(Never?) onClosed;

  const _ProfileEditToggle({super.key, required this.onClosed});

  @override
  Widget build(BuildContext context) {
    return _FadeThroughTransitionSwitcher(
      fillColor: Colors.transparent,
      child: OpenContainer(
        openBuilder: (context, closedContainer) {
          return ChangeNotifierProvider(
              create: (_) => ProfileEditProvider(),
              builder: (_, child) => const ProfileEditPage());
        },
        onClosed: onClosed,
        closedShape: InputBorder.none,
        closedElevation: 0,
        closedBuilder: (context, openContainer) {
          return ColoredBackgroundButton(
              onPressed: openContainer,
              text: context.language.edit,
              buttonColor: ColoredButtonType.green);
        },
      ),
    );
  }
}

class _FadeThroughTransitionSwitcher extends StatelessWidget {
  const _FadeThroughTransitionSwitcher({
    required this.fillColor,
    required this.child,
  });

  final Widget child;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          fillColor: fillColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: child,
    );
  }
}
