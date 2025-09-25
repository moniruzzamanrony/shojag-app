import 'package:app/core/utils/enums/notification_type.dart';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/router/routes.dart';
import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/constants/dimens.dart';
import '../../../../../shared/presentation/widget/custom_app_bar.dart';
import '../../list/page/fnf_list_page.dart';

class FnfHomePage extends StatefulWidget {
  final bool _fromNotification;
  final NotificationType _notificationType;
  final int? _fnfId;

  const FnfHomePage(
      {super.key,
      bool fromNotification = false,
      NotificationType notificationType = NotificationType.none,
      int? fnfId})
      : _fromNotification = fromNotification,
        _notificationType = notificationType,
        _fnfId = fnfId;

  @override
  State<FnfHomePage> createState() => _FnfHomePageState();
}

class _FnfHomePageState extends State<FnfHomePage> {
  late final ScrollController _scrollController;
  late final ValueNotifier<bool> _buttonVisibilityNotifier;

  @override
  void initState() {
    super.initState();
    _buttonVisibilityNotifier = ValueNotifier<bool>(true);
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _buttonVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBackground(
          child: Column(
        children: [
          CustomAppBar(title: context.language.fnfLocator),
          Expanded(
              child: Stack(
            children: [
              CurvedTopRadiusToChild(
                backgroundColor: AppColors.scaffoldBackgroundColorPaleMint,
                child: FnfListPage(
                  scrollController: _scrollController,
                  fromNotification: widget._fromNotification,
                  notificationType: widget._notificationType,
                  fnfId: widget._fnfId,
                ),
              ),
              Positioned(
                  right: 16.w, bottom: 32.h, child: _addButtonSection(context))
            ],
          ))
        ],
      )),
    );
  }

  Widget _addButtonSection(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: _buttonVisibilityNotifier,
        builder: (_, value, __) => AnimatedScale(
            scale: value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton.extended(
                icon: Icon(
                  Icons.add,
                  size: Dimens.iconSize16,
                ),
                onPressed: () {
                  context.pushNamed(Routes.fnfSearch);
                },
                label: Text(context.language.addNewFnF))),
      ),
    );
  }

  void _handleScroll() {
    final isButtonVisible = _buttonVisibilityNotifier.value;
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isButtonVisible) {
        _buttonVisibilityNotifier.value = false;
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isButtonVisible) {
        _buttonVisibilityNotifier.value = true;
      }
    }
  }
}
