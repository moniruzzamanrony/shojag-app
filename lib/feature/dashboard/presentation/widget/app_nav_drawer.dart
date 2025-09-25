import 'package:app/core/utils/constants/app_constants.dart';
import 'package:app/core/utils/constants/dimens.dart';
import 'package:app/core/utils/enums/list_type.dart';
import 'package:app/core/utils/enums/main_menu.dart';
import 'package:app/core/utils/extension/color_extension.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/core/utils/extension/number_extension.dart';
import 'package:app/feature/alert/presentation/list/provider/alert_list_provider.dart';
import 'package:app/feature/dashboard/presentation/provider/nav_menu_provider.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/drop_lottie_anim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/router/routes.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/utils/constants/assets.dart';
import '../../../../core/utils/enums/alert_type.dart';
import '../../../../core/utils/enums/user_type.dart';
import '../../../../core/utils/style/style.dart';
import '../../../alert/presentation/incident_provider.dart';
import '../../../premium/presentation/provider/premium_provider.dart';
import '../provider/dashboard_provider.dart';

class AppNavDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const AppNavDrawer({super.key, required this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: NavBackground(
        child: SafeArea(
          child: Selector<NavMenuProvider, MainMenu>(
            selector: (_, provider) => provider.selectedMainMenu,
            builder: (_, value, __) => ListView(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 70.r,
                      width: 70.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SimpleLottie(Assets.pulseCircleDropJson),
                          SvgPicture.asset(
                            Assets.shojagLogoSvg,
                            height: 48.r,
                            width: 48.r,
                          ),
                        ],
                      ),
                    ),
                    10.gapW,
                    SvgPicture.asset(
                      Assets.shojagPoweredByLogoEnSvg,
                      width: 150.w,
                      colorFilter: const ColorFilter.mode(
                          AppColors.colorBlack, BlendMode.srcIn),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _closeDrawer(context);
                      },
                      child: CircleAvatar(
                          backgroundColor: AppColors.colorAppRed,
                          radius: 14.r,
                          child: Icon(
                            Icons.close,
                            color: AppColors.colorWhite,
                            size: 14.r,
                          )),
                    ),
                    16.gapW,
                  ],
                ),
                40.gapH,
                _MainMenu(
                  buttonText: context.language.home,
                  leadingIcon: Icons.home_filled,
                  hasTrailingIcon: false,
                  menu: MainMenu.home,
                  isSelected: value == MainMenu.home,
                  onTap: () {
                    _closeDrawer(context);
                    if (context.mounted) {
                      context.goNamed(Routes.dashboard);
                      context
                          .read<DashboardProvider>()
                          .pageController
                          .animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                    }
                  },
                ),
                if (context.userType == UserType.citizen)
                  _MainMenu(
                    buttonText: context.language.newAlert,
                    leadingIcon: Icons.add,
                    hasTrailingIcon: true,
                    menu: MainMenu.alertCreate,
                    isSelected: value == MainMenu.alertCreate,
                    submenus: [
                      _SubMenu(
                          buttonText: context.language.community,
                          leadingIcon: Icons.people,
                          onTap: () async {
                            _closeDrawer(context);
                            await context
                                .read<IncidentProvider>()
                                .getIncidentList(
                                    categoryId: AlertType.community.id);
                            if (context.mounted) {
                              context.goNamed(Routes.alertAdd,
                                  extra: AlertType.community);
                            }
                          }),
                      _SubMenu(
                          buttonText: context.language.police,
                          leadingIcon: Icons.security,
                          onTap: () async {
                            _closeDrawer(context);
                            _closeDrawer(context);
                            await context
                                .read<IncidentProvider>()
                                .getIncidentList(
                                    categoryId: AlertType.police.id);
                            if (context.mounted) {
                              context.goNamed(Routes.alertAdd,
                                  extra: AlertType.police);
                            }
                          }),
                      _SubMenu(
                          buttonText: context.language.fire_service,
                          leadingIcon: Icons.fire_truck,
                          onTap: () async {
                            _closeDrawer(context);
                            await context
                                .read<IncidentProvider>()
                                .getIncidentList(
                                    categoryId: AlertType.fireService.id);
                            if (context.mounted) {
                              context.goNamed(Routes.alertAdd,
                                  extra: AlertType.fireService);
                            }
                          }),
                      _SubMenu(
                          buttonText: context.language.ambulance,
                          leadingIcon: Icons.car_repair,
                          onTap: () async {
                            _closeDrawer(context);
                            await context
                                .read<IncidentProvider>()
                                .getIncidentList(
                                    categoryId: AlertType.ambulance.id);
                            if (context.mounted) {
                              context.goNamed(Routes.alertAdd,
                                  extra: AlertType.ambulance);
                            }
                          }),
                    ],
                  ),
                _MainMenu(
                  buttonText: context.language.alertList,
                  leadingIcon: Icons.crisis_alert,
                  hasTrailingIcon: true,
                  menu: MainMenu.alertList,
                  isSelected: value == MainMenu.alertList,
                  submenus: [
                    if (context.isCitizen)
                      _SubMenu(
                        buttonText: context.language.myAlerts,
                        onTap: () {
                          _closeDrawer(context);
                          context
                              .read<AlertListProvider>()
                              .updateListType(ListType.myAlerts);
                          context.goNamed(Routes.alertList);
                        },
                      ),
                    _SubMenu(
                      buttonText: context.language.respondedAlerts,
                      onTap: () {
                        _closeDrawer(context);
                        context
                            .read<AlertListProvider>()
                            .updateListType(ListType.responded);
                        context.goNamed(Routes.alertList);
                      },
                    ),
                    _SubMenu(
                      buttonText: context.language.activeAlerts,
                      onTap: () {
                        _closeDrawer(context);
                        context
                            .read<AlertListProvider>()
                            .updateListType(ListType.active);
                        context.goNamed(Routes.alertList);
                      },
                    ),
                    _SubMenu(
                      buttonText: context.language.closedAlerts,
                      onTap: () {
                        _closeDrawer(context);
                        context
                            .read<AlertListProvider>()
                            .updateListType(ListType.closed);
                        context.goNamed(Routes.alertList);
                      },
                      isLastItem: true,
                    ),
                  ],
                ),
                _MainMenu(
                  buttonText: context.language.settings,
                  leadingIcon: Icons.settings,
                  hasTrailingIcon: false,
                  menu: MainMenu.settings,
                  isSelected: value == MainMenu.settings,
                  onTap: () {
                    _closeDrawer(context);
                    context.goNamed(Routes.settings);
                  },
                ),
                _MainMenu(
                  buttonText: context.language.feedback,
                  leadingIcon: Icons.feedback,
                  hasTrailingIcon: false,
                  menu: MainMenu.feedback,
                  isSelected: value == MainMenu.version,
                  onTap: () {
                    _closeDrawer(context);
                    context.goNamed(Routes.feedback);
                  },
                ),
                _MainMenu(
                  buttonText: context.language.privacyPolicy,
                  leadingIcon: Icons.privacy_tip,
                  hasTrailingIcon: false,
                  menu: MainMenu.privacyPolicy,
                  isSelected: value == MainMenu.privacyPolicy,
                  onTap: () async {
                    _closeDrawer(context);
                    if (await canLaunchUrl(
                        Uri.parse(AppConstants.privacyPolicyUrl))) {
                      launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));
                    }
                  },
                ),
                // _MainMenu(
                //   buttonText: context.language.invite,
                //   leadingIcon: Icons.share,
                //   hasTrailingIcon: false,
                //   menu: MainMenu.invite,
                //   isSelected: value == MainMenu.invite,
                //   onTap: _shareShojag,
                // ),
                _MainMenu(
                  buttonText: context.language.version,
                  leadingIcon: Icons.layers,
                  hasTrailingIcon: false,
                  menu: MainMenu.version,
                  trailingText: AppConstants.appVersion,
                  isSelected: value == MainMenu.version,
                  onTap: () {},
                ),
                80.gapH,
                if (context.isCitizen)
                  Selector<PremiumProvider, bool>(
                    selector: (_, provider) =>
                        provider.premiumEntity.isValidPremiumUser,
                    builder: (_, isValidPremiumUser, __) => InkWell(
                      onTap: () {
                        //_closeDrawer(context);
                        if (isValidPremiumUser) {
                          context.goNamed(Routes.subscriptionHome);
                        } else {
                          context.goNamed(Routes.premiumPackageSelection);
                        }
                      },
                      child: Padding(
                        padding: Styles.horizontalPadding,
                        child: Row(
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: AppColors.colorGrey,
                              size: Dimens.iconSize20,
                            ),
                            10.gapW,
                            Text(
                              isValidPremiumUser
                                  ? context.language.currentSubscription
                                  : context.language.tryPremiumFeatures,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            8.gapW,
                            //const Spacer(),
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      color: context.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(6.r)),
                                  child: Text(
                                    isValidPremiumUser
                                        ? context.language.pro
                                        : context.language.upgradeToPro,
                                    style: TextStyle(
                                        color: context.colorScheme.onPrimary,
                                        fontSize: 12.sp),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _shareShojag() {
    final message = '''
Hey! 🌟

I’m using Shojag, a smart safety app that helps me stay connected with my friends and family by sharing my live location and receiving alerts when someone I care about arrives or leaves a place. 🏡📍

It’s super helpful and comforting — I think you'll love it too!

Download Shojag and stay connected with me:

🤖 Android: https://play.google.com/store/apps/details?id=com.shojag.app  

 iOS: https://apps.apple.com/app/shojag/id6743643122

Let’s stay safe and connected with Shojag! ❤️
''';

    SharePlus.instance.share(ShareParams(text: message, title: 'Share'));
  }

  void _closeDrawer(BuildContext ctx) {
    if (drawerKey.currentState?.isDrawerOpen ?? false) {
      drawerKey.currentState?.closeDrawer();
      ctx.read<NavMenuProvider>().resetAll();
    }
  }
}

class _MainMenu extends StatefulWidget {
  final String buttonText;
  final IconData leadingIcon;
  final bool hasTrailingIcon;
  final MainMenu menu;
  final String? trailingText;
  final List<_SubMenu>? submenus;
  final bool isSelected;
  final bool hasBottomDivider;
  final void Function()? onTap;

  const _MainMenu({
    super.key,
    required this.buttonText,
    required this.leadingIcon,
    required this.hasTrailingIcon,
    required this.menu,
    this.trailingText,
    this.submenus,
    required this.isSelected,
    this.hasBottomDivider = true,
    this.onTap,
  });

  @override
  State<_MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<_MainMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  late Duration duration;

  late bool isExpanded;

  @override
  void didUpdateWidget(covariant _MainMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    isExpanded = widget.isSelected;
    _runExpandCheck();
  }

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isSelected;

    duration = const Duration(milliseconds: 350);

    expandController = AnimationController(vsync: this, duration: duration);
    animation =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    isExpanded = widget.isSelected;

    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void _runExpandCheck() {
    if (isExpanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.colorScheme.primary;
    const unselectedColor = AppColors.colorGrey;

    return Column(
      children: [
        InkWell(
          onTap: widget.onTap ??
              () {
                final navMenuProvider = context.read<NavMenuProvider>();
                if (navMenuProvider.selectedMainMenu != widget.menu) {
                  navMenuProvider.updateMainMenu(widget.menu);
                }
                isExpanded = !isExpanded;
                _runExpandCheck();
                setState(() {});
              },
          child: AnimatedContainer(
            height: 48.h,
            color: widget.isSelected ? AppColors.colorWhite : null,
            padding: Styles.horizontalPadding,
            duration: duration,
            child: Row(
              children: [
                Icon(
                  widget.leadingIcon,
                  color: widget.isSelected ? selectedColor : unselectedColor,
                  size: Dimens.iconSize20,
                ),
                10.gapW,
                Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: widget.isSelected ? selectedColor : unselectedColor,
                  ),
                ),
                const Spacer(),
                if (widget.hasTrailingIcon)
                  AnimatedRotation(
                    turns: isExpanded ? -0.25 : 0,
                    duration: duration,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color:
                          widget.isSelected ? selectedColor : unselectedColor,
                      size: Dimens.iconSize20,
                    ),
                  ),
                if (widget.trailingText != null)
                  Text(
                    widget.trailingText!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color:
                          widget.isSelected ? selectedColor : unselectedColor,
                    ),
                  )
              ],
            ),
          ),
        ),
        if (widget.hasBottomDivider)
          Divider(
            color: Colors.white.shade(15, darker: true),
            height: 0,
            indent: Dimens.horizontalSpace,
            endIndent: Dimens.horizontalSpace,
          ),
        if (widget.submenus != null)
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.submenus!,
            ),
          )
      ],
    );
  }
}

class _SubMenu extends StatelessWidget {
  final String buttonText;
  final bool isLastItem;
  final void Function()? onTap;
  final IconData? leadingIcon;

  const _SubMenu(
      {super.key,
      required this.buttonText,
      this.isLastItem = false,
      this.onTap,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40.h,
            width: double.infinity,
            color: AppColors.kNavBarBackground.shade(100),
            padding: Styles.horizontalPadding,
            child: Row(
              children: [
                50.gapW,
                if (leadingIcon == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 3.r),
                          child: VerticalDivider(
                            color: AppColors.colorGrey,
                            width: 0,
                            thickness: 1.r,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: const BoxDecoration(
                                color: AppColors.colorGrey,
                                shape: BoxShape.circle),
                          ),
                          Container(
                            width: 10.w,
                            height: 1.r,
                            decoration:
                                const BoxDecoration(color: AppColors.colorGrey),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 3.r),
                          child: VerticalDivider(
                            color: AppColors.colorGrey,
                            width: 0,
                            thickness: isLastItem ? 0 : 1.r,
                          ),
                        ),
                      )
                    ],
                  )
                else
                  Icon(
                    leadingIcon!,
                    color: AppColors.colorGrey,
                    size: Dimens.iconSize20,
                  ),
                10.gapW,
                Text(
                  buttonText,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorGrey),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white.shade(15, darker: true),
            height: 0,
            indent: Dimens.horizontalSpace,
            endIndent: Dimens.horizontalSpace,
          ),
        ],
      ),
    );
  }
}
