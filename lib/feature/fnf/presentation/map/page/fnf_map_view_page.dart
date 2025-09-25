import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/fnf/presentation/map/provider/fnf_map_view_provider.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_location_address_widget.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_map_add_widget.dart';
import 'package:app/feature/fnf/presentation/map/widget/fnf_map_view_widget.dart';
import 'package:app/shared/presentation/widget/background.dart';
import 'package:app/shared/presentation/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FnfMapViewPage extends ConsumerWidget {

  const FnfMapViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fnfMapViewProvider);
    final model = state.model;
    return Scaffold(
      body: HomeBackground(
          child: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
                title: (state.viewState == AddressViewState.add
                    ? context.language.newPlace
                    : context.language.locationWithUserName(model.userName))),
            Expanded(
                child: CurvedTopRadiusToChild(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: state.viewState == AddressViewState.view
                        ? const FnfMapViewWidget()
                        : const FnfMapAddWidget(),
                  ),
                  Positioned(
                      right: 16.w,
                      top: 16.h,
                      left: 16.w,
                      child: const FnfLocationAddressWidget()),
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
