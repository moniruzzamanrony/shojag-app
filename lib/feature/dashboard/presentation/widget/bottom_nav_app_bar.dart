// bottom navigation bar

import 'package:animations/animations.dart';
import 'package:app/core/config/theme/app_colors.dart';
import 'package:app/core/utils/constants/assets.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/core/utils/style/style.dart';
import 'package:app/feature/app_tour_tutorial/presentation/utils/tutorial_data.dart';
import 'package:app/feature/home/presentation/widget/my_active_alert_bottom_sheet.dart';
import 'package:app/feature/premium/presentation/widget/premium_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/user_type.dart';
import '../../../fnf/presentation/home/page/fnf_home_page.dart';
import '../provider/dashboard_provider.dart';

enum NavMenu {
  home(0),
  map(1),
  profile(2),
  emergency(3);

  const NavMenu(this.i);

  final int i;

  factory NavMenu.fromIndex(int i) {
    switch (i) {
      case 0:
        return NavMenu.home;
      case 1:
        return NavMenu.map;
      case 2:
        return NavMenu.profile;
      case 3:
        return NavMenu.emergency;
      default:
        return NavMenu.home;
    }
  }
}

class BottomNavAppBar extends StatelessWidget {
  const BottomNavAppBar({super.key});

  Widget _buildBottomButtons(
      BuildContext context, int currentIndex, bool hasNotchedButton) {
    final selectedNavMenu = NavMenu.fromIndex(currentIndex);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavMenuItem(
              id: NavMenu.home,
              title: context.language.home,
              onPressed: () {
                context.read<DashboardProvider>().animateToPage(NavMenu.home.i);
              },
              isSelected: selectedNavMenu == NavMenu.home,
              icon: Assets.navHomeSvg),
          _NavMenuItem(
              id: NavMenu.map,
              title: context.language.map,
              onPressed: () {
                context.read<DashboardProvider>().animateToPage(NavMenu.map.i);
              },
              isSelected: selectedNavMenu == NavMenu.map,
              icon: Assets.navMapSvg),
          if (hasNotchedButton) 30.gapW,
          _NavMenuItem(
              id: NavMenu.profile,
              title: context.language.profile,
              onPressed: () {
                context
                    .read<DashboardProvider>()
                    .animateToPage(NavMenu.profile.i);
              },
              isSelected: selectedNavMenu == NavMenu.profile,
              icon: Assets.navProfileSvg),
          _NavMenuItem(
              id: NavMenu.emergency,
              title: context.language.tripleNine,
              onPressed: () {
                context
                    .read<DashboardProvider>()
                    .animateToPage(NavMenu.emergency.i);
              },
              isSelected: selectedNavMenu == NavMenu.emergency,
              icon: Assets.navEmergencySvg),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCitizenProfile = context.userType == UserType.citizen;
    return SafeArea(
      child: Stack(
        children: [
          //bottom sheet if active alerts
          Positioned(
              left: 0,
              right: 0,
              bottom: 72.h,
              child: const MyActiveAlertBottomSheet()),

          // Bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 64.h,
              child: ClipPath(
                clipper: isCitizenProfile ? CustomBottomBarClipper() : null,
                child: Selector<DashboardProvider, int>(
                  selector: (_, provider) => provider.currentIndex,
                  builder: (_, value, __) => Container(
                      margin: Styles.horizontalPadding.copyWith(bottom: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: AppColors.colorAppGreenDark),
                      child: _buildBottomButtons(
                          context, value, isCitizenProfile)),
                ),
              ),
            ),
          ),

          // Friends and Family (FnF) icon
          if (isCitizenProfile)
            Positioned(
              left: 0,
              right: 0,
              bottom: 40.h,
              child: Center(
                child: OpenContainer(
                  clipBehavior: Clip.none,
                  openColor: Colors.transparent,
                  closedColor: Colors.transparent,
                  openElevation: 0,
                  closedElevation: 0,
                  tappable: false,
                  openBuilder: (_, action) => const FnfHomePage(),
                  closedBuilder: (context, action) => GestureDetector(
                    onTap: action,
                    child: PremiumButtonWidget(
                      key: TutorialKeys.fnfButtonKey,
                      size: 24.r,
                      child: Container(
                        height: 48.r,
                        width: 48.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(Assets.navFnfSvg,
                            height: 28.r,
                            width: 28.r,
                            colorFilter: const ColorFilter.mode(
                                AppColors.colorWhite, BlendMode.srcATop)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomBottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 32.r;
    Path path = Path()
      ..lineTo(size.width / 2 - radius, 0)
      ..arcToPoint(
        Offset(size.width / 2 + radius, 0),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => this != oldClipper;
}

class _NavMenuItem extends StatelessWidget {
  final NavMenu id;
  final void Function() onPressed;
  final String icon;
  final String title;
  final bool isSelected;

  const _NavMenuItem(
      {required this.onPressed,
      required this.icon,
      required this.title,
      required this.isSelected,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final selectedColor = AppColors.colorWhite;
    final unselectedColor = AppColors.colorAppBlueDark.shade(240);
    final duration = const Duration(milliseconds: 300);
    final curve = Curves.decelerate;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 2.r),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colorAppBlueDark.shade(100).withAlpha(150)
              : AppColors.colorAppTransparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filledTonal(
              style: IconButton.styleFrom(
                  visualDensity: Styles.minimumVisualDensity,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent
                  // backgroundColor: isSelected
                  //     ? AppColors.colorAppBlueDark.shade(100).withAlpha(150)
                  //     : AppColors.colorAppTransparent,
                  ),
              onPressed: null,
              icon: AnimatedScale(
                duration: duration,
                scale: isSelected ? 1.2 : 1,
                curve: curve,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.r, vertical: 4.r),
                  child: SvgPicture.asset(
                    icon,
                    height: 12.r,
                    width: 12.r,
                    colorFilter: ColorFilter.mode(
                        isSelected ? selectedColor : unselectedColor,
                        BlendMode.srcATop),
                  ),
                ),
              ),
            ),
            //2.gapH,
            AnimatedDefaultTextStyle(
              style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  height: 1.0),
              duration: duration,
              curve: curve,
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
